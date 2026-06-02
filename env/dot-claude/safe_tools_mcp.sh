#!/bin/bash
# Wrapper for safe_tools_mcp.py — finds uv on common Homebrew paths
# so Claude Code can spawn the MCP server without relying on shell PATH init.
set -e
for p in "$HOME/homebrew/bin" /opt/homebrew/bin /usr/local/bin; do
  if [ -x "$p/uv" ]; then
    export PATH="$p:$PATH"
    break
  fi
done
exec uv run --script "$HOME/.claude/safe_tools_mcp.py"
