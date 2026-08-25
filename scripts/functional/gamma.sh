#!/bin/bash

OUTPUT="DP-2"

current=$(xrandr --verbose | grep -A 10 "$OUTPUT" | grep "Gamma:" | awk '{print $2}')

current_val=$(echo "$current" | cut -d':' -f1)

if [[ "$current_val" == "1.0" ]]; then
    new_gamma="1.5:1.5:1.5"
elif [[ "$current_val" == "0.67" ]]; then
    new_gamma="2.0:2.0:2.0"
elif [[ "$current_val" == "0.5" ]]; then
    new_gamma="1.0:1.0:1.0"
else
    new_gamma="1.0:1.0:1.0"
fi

xrandr --output "$OUTPUT" --gamma "$new_gamma"

echo "Gamma changed to $new_gamma (xrandr shows: $(xrandr --verbose | grep -A 10 "$OUTPUT" | grep "Gamma:" | awk '{print $2}'))"