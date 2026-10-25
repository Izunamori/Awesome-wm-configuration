#!/bin/bash

OUTPUT="DP-2"
STATE_FILE="$HOME/.cache/gamma_state"

mkdir -p "$(dirname "$STATE_FILE")"

current=$(cat "$STATE_FILE" 2>/dev/null || echo "1.0")

case "$current" in
    1.0)
        new_gamma="1.2:1.2:1.2"
        new_state="1.2"
        ;;
    1.2)
        new_gamma="1.5:1.5:1.5"
        new_state="1.5"
        ;;
    1.5)
        new_gamma="2.0:2.0:2.0"
        new_state="2.0"
        ;;
    2.0)
        new_gamma="1.0:1.0:1.0"
        new_state="1.0"
        ;;
    *)
        new_gamma="1.0:1.0:1.0"
        new_state="1.0"
        ;;
esac

xrandr --output "$OUTPUT" --gamma "$new_gamma"

echo "$new_state" > "$STATE_FILE"

echo "Gamma changed to $new_gamma"