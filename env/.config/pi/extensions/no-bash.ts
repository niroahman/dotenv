/**
 * L5 global template — no bash tool.
 *
 * Two layers:
 *   1. tool_call unconditionally blocks bash.
 *   2. Three safe replacement tools: run_tests, git_status, list_dir.
 *
 * Usage: symlink into a project's .pi/extensions/ directory.
 *   ln -sf ~/.config/pi/extensions/no-bash.ts .pi/extensions/no-bash.ts
 *
 * Invoke pi without bash in --tools:
 *   pi --tools read,edit,write,grep,find,run_tests,git_status,list_dir
 */

import { execFile } from "node:child_process";
import { readdirSync } from "node:fs";
import { promisify } from "node:util";
import { resolve } from "node:path";
import { Type } from "typebox";

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

const exec = promisify(execFile);

export default function noBashExtension(pi: ExtensionAPI) {
  pi.on("tool_call", async (event) => {
    if (event.toolName === "bash") {
      return {
        block: true,
        reason:
          "L5: bash disabled by policy. Use run_tests, git_status, or list_dir instead.",
      };
    }
    return undefined;
  });

  pi.registerTool({
    name: "run_tests",
    label: "Run Tests",
    description: "Run the project test suite (uv run pytest -q). Returns trailing 2KB.",
    parameters: Type.Object({}),
    async execute(_id, _params, _signal, _onUpdate, _ctx) {
      try {
        const { stdout, stderr } = await exec("uv", ["run", "pytest", "-q"], {
          cwd: process.cwd(),
          timeout: 60_000,
        });
        return {
          content: [{ type: "text", text: (stdout + stderr).slice(-2000) || "(no output)" }],
          details: { exitCode: 0 },
        };
      } catch (err: any) {
        return {
          content: [{ type: "text", text: ((err.stdout ?? "") + (err.stderr ?? err.message)).slice(-2000) }],
          details: { exitCode: err.code ?? 1 },
          isError: true,
        };
      }
    },
  });

  pi.registerTool({
    name: "git_status",
    label: "Git Status",
    description: "Short git status (porcelain + branch) for the current directory.",
    parameters: Type.Object({}),
    async execute(_id, _params, _signal, _onUpdate, _ctx) {
      try {
        const { stdout } = await exec("git", ["status", "--porcelain", "-b"], {
          cwd: process.cwd(),
        });
        return { content: [{ type: "text", text: stdout || "(clean)" }], details: {} };
      } catch (err: any) {
        return { content: [{ type: "text", text: err.message }], details: {}, isError: true };
      }
    },
  });

  pi.registerTool({
    name: "list_dir",
    label: "List Directory",
    description: "List filenames in a directory. Names only — no file contents.",
    parameters: Type.Object({
      path: Type.String({ default: ".", description: "Directory path to list" }),
    }),
    async execute(_id, params: { path?: string }, _signal, _onUpdate, _ctx) {
      const target = resolve(params.path ?? ".");
      try {
        const entries = readdirSync(target, { withFileTypes: true })
          .map((e) => e.name)
          .sort();
        return {
          content: [{ type: "text", text: entries.join("\n") || "(empty)" }],
          details: {},
        };
      } catch (err: any) {
        return {
          content: [{ type: "text", text: `${target}: ${err.message}` }],
          details: {},
          isError: true,
        };
      }
    },
  });
}
