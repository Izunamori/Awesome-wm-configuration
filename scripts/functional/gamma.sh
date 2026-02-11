#!/bin/bash

OUTPUT="DP-2"
current=$(xrandr --verbose | grep -A 10 "$OUTPUT" | grep "Gamma:" | awk '{print $2}')

if [[ "$current" == *"1:1:1"* ]] || [[ "$current" == *"1.0:1.0:1.0"* ]]; then
    xrandr --output "$OUTPUT" --gamma 2:2:2
else
    xrandr --output "$OUTPUT" --gamma 1:1:1
fi