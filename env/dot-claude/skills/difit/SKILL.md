---
name: difit
description: Start a difit local diff-review session (GitHub-like UI) so the user can leave inline comments, then get those comments back automatically when they close the tab. Use when the user says "run difit", "/difit", "start a difit session", or asks to review a diff with difit.
---

Start a `difit` review session. Default mode auto-opens the browser and auto-exits (printing all comments) when the user closes the tab — matches running plain `difit` yourself.

## Default: auto-open, auto-exit on tab close

1. Run via the Bash tool with `run_in_background: true` (this is normal foreground `difit`, not its own `--background` flag — the backgrounding here is only so it doesn't block the conversation while the user reviews):
   ```
   npx difit <target>
   ```
   - `<target>` defaults to `working` (current uncommitted working-tree diff vs `HEAD`) when the user doesn't specify one.
   - If the user gives arguments (a commit-ish, a `commit-ish compare-with` pair, or `--pr <url>`), use those instead of `working`.
   - By default, only tracked files show up (no `--include-untracked`). Only add `--include-untracked` if the user explicitly asks to see new/untracked files too.
   - Do not pass `--no-open`, `--background`, or `--keep-alive` in this default mode — the browser auto-opens, and the server auto-exits the moment the tab is closed, printing a `📝 Comments from review session` summary to stdout before exiting.
2. Tell the user a browser tab should have opened, and to leave comments then close the tab when done — no need to tell you "done" separately, since closing the tab is what triggers the output.
3. Wait for the task-completion notification, then read the task's output file. Parse the printed comment summary (file:line + body per thread, `Total comments: N`). If `N` is 0, say so plainly.
4. Summarize each thread's file/line and comment body, and act on anything actionable. If a thread is on a file that isn't part of the actual work (e.g. a stray untracked artifact, if `--include-untracked` was used), say so rather than treating it as a code-review note.

## Alternative: persistent session (only if the user asks for it)

If the user explicitly wants the server to survive tab closes (e.g. to review across multiple sittings), use `--background --keep-alive` instead:
```
npx difit <target> --background --keep-alive
```
This prints `{"port":...,"url":...,"pid":...}` immediately and exits without blocking — hand the user the `url` as a clickable link and remember the port. Fetch comments on demand with:
```
npx difit comment get --port <port> --format json
```
Don't kill this server on your own initiative — ask first, then `kill <pid>` if confirmed.
