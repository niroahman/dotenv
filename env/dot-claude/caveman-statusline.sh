#!/usr/bin/env bash
# Finds the caveman statusline script regardless of plugin cache hash.
script=$(find "$HOME/.claude/plugins/cache/caveman" -name "caveman-statusline.sh" 2>/dev/null | head -1)
[[ -n $script ]] && exec bash "$script"
