# AGENTS.md

Guidance for AI coding agents (Claude Code, Cursor, Codex, Aider, etc.)
working in this repo.

## Entry points

```bash
./install              # Full bootstrap: brew check → runs/* → dev-env symlinks
./install --dry        # Preview all steps without executing
./install <filter>     # Run only scripts whose name matches <filter> (e.g. ./install brew)
./dev-env              # Symlink dotfiles only (skips runs/)
./dev-env --dry        # Preview symlink operations
scripts/brewsync       # Regenerate Brewfile from live Homebrew state
```

## How dotfiles are deployed

`dev-env` creates symlinks, never copies:

| Source | Target |
|--------|--------|
| `env/.config/<tool>/` | `~/.config/<tool>` (directory symlink) |
| `env/.config/<file>.*` | `~/.config/<file>.*` (file symlink) |
| `env/.<file>` | `~/<file>` (file symlink) |
| `env/dot-claude/*` | `~/.claude/*` (individual file symlinks) |
| `scripts/*` | `~/scripts/*` |

If target exists as a real file, `dev-env` backs it up as `<target>.bak`
before linking. If already a symlink pointing elsewhere, it relinks.

## Adding a new tool config

1. Put config under `env/.config/<toolname>/` or `env/.<dotfile>`
2. Re-run `./dev-env` — the loop auto-discovers it, no edits needed

## Adding a new install script

1. Create `runs/<name>` as an executable bash script
2. `./install` auto-discovers and runs all executable files in `runs/` (max depth 1)
3. Order: brew runs first; everything else runs in filesystem order

## Gitignored intentionally

- `env/.config/karabiner/karabiner.json` — Karabiner manages this file itself; edit via the Karabiner-Elements UI
- `env/.config/tmux/plugins/` — TPM installs these at runtime (`prefix + I`)
- `errors.log`

## Agent security (L5)

Claude Code runs with `permissions.deny: ["Bash"]` globally via
`env/dot-claude/settings.json`. A safe-tools MCP server
(`env/dot-claude/safe_tools_mcp.py`) provides narrow replacements:
`run_tests`, `git_status`, `git_log`, `git_diff`, `git_commit`,
`run_install`, `run_linter`, `list_dir`, `check_tool`.

To opt a project back in to bash, add `.claude/settings.json`:

```json
{ "permissions": { "allow": ["Bash"] } }
```

Pi: `env/.config/pi/extensions/no-bash.ts` is a template. Symlink it
into any project's `.pi/extensions/` to enable L5 for Pi in that
project:

```bash
ln -sf ~/.config/pi/extensions/no-bash.ts .pi/extensions/no-bash.ts
pi --tools read,edit,write,grep,find,run_tests,git_status,list_dir
```

## Known stubs

- `runs/neovim` — empty placeholder, neovim install not yet scripted
