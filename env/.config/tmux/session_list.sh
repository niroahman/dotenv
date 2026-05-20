#!/usr/bin/env bash
current=$(tmux display-message -p '#S')
green=$(tmux display-message -p '#{@thm_green}')
surface0=$(tmux display-message -p '#{@thm_surface_0}')
crust=$(tmux display-message -p '#{@thm_crust}')

tmux list-sessions -F '#S' 2>/dev/null | while IFS= read -r s; do
  if [ "$s" = "$current" ]; then
    printf '#[fg=%s,bg=%s,bold] %s #[default]' "$crust" "$green" "$s"
  else
    printf '#[fg=%s,bg=%s] %s #[default]' "$green" "$surface0" "$s"
  fi
done
