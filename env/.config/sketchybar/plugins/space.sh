#!/bin/sh

case "$SENDER" in
    "mouse.clicked")
        case "$SID" in
            1) osascript -e 'tell app "System Events" to key code 18 using {control down, option down, shift down, command down}' ;;
            2) osascript -e 'tell app "System Events" to key code 19 using {control down, option down, shift down, command down}' ;;
            3) osascript -e 'tell app "System Events" to key code 20 using {control down, option down, shift down, command down}' ;;
            4) osascript -e 'tell app "System Events" to key code 21 using {control down, option down, shift down, command down}' ;;
            5) osascript -e 'tell app "System Events" to key code 23 using {control down, option down, shift down, command down}' ;;
            6) osascript -e 'tell app "System Events" to key code 22 using {control down, option down, shift down, command down}' ;;
            7) osascript -e 'tell app "System Events" to key code 26 using {control down}' ;;
            8) osascript -e 'tell app "System Events" to key code 28 using {control down}' ;;
        esac
        ;;
    *)
        if [ "$SELECTED" = "true" ]; then
            sketchybar --set "$NAME" background.drawing=on icon.color=0xff1e1e2e
        else
            sketchybar --set "$NAME" background.drawing=off icon.color=0xffcdd6f4
        fi
        ;;
esac
