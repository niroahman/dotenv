#!/usr/bin/env sh
WS="${NAME#aws.}"
FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null)

if [ "$WS" = "$FOCUSED" ]; then
    sketchybar --set "$NAME" background.drawing=on icon.color=0xff1e1e2e
else
    sketchybar --set "$NAME" background.drawing=off icon.color=0xffcdd6f4
fi
