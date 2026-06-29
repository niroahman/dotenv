#!/usr/bin/env bash
path="${1:-$HOME}"
current=$(tmux display-message -p '#S')
host=$(hostname -s)
branch=$(git -C "$path" rev-parse --abbrev-ref HEAD 2>/dev/null)
repo=$(basename "$(git -C "$path" rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)

green=$(tmux display-message -p '#{@thm_green}')
lavender=$(tmux display-message -p '#{@thm_lavender}')
subtext1=$(tmux display-message -p '#{@thm_subtext_1}')

[ -z "$green" ]    && green="#a6e3a1"
[ -z "$lavender" ] && lavender="#b4befe"
[ -z "$subtext1" ] && subtext1="#a6adc8"

sep="#[fg=${subtext1}]  │  "

printf '#[fg=%s] %s' "$subtext1" "$host"
printf '%s' "$sep"
printf '#[fg=%s,bold] %s#[nobold]' "$green" "$current"

if [ -n "$branch" ]; then
  printf '%s' "$sep"
  printf '#[fg=%s]%s → %s' "$lavender" "$repo" "$branch"
fi

printf ' '
