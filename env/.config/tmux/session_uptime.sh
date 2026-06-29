#!/usr/bin/env bash
created="$1"
now=$(date +%s)
diff=$((now - created))
h=$((diff / 3600))
m=$(((diff % 3600) / 60))
if [ "$h" -gt 0 ]; then
  printf '󱎫 %dh %dm' "$h" "$m"
else
  printf '󱎫 %dm' "$m"
fi
