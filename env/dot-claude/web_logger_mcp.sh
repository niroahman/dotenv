#!/bin/bash
# Launcher for web_logger_mcp.py — finds uv on common Homebrew paths.
set -e
for p in "$HOME/homebrew/bin" /opt/homebrew/bin /usr/local/bin; do
  if [ -x "$p/uv" ]; then
    export PATH="$p:$PATH"
    break
  fi
done
export PYTHONUNBUFFERED=1
exec uv run --script "$HOME/.claude/web_logger_mcp.py"
