#!/bin/bash

OUTPUT="DP-0"
current=$(xrandr --verbose | grep -A 10 "$OUTPUT" | grep "Gamma:" | awk '{print $2}')

echo "Текущая гамма: $current"

# Если гамма содержит "1:1:1" или "1.0:1.0:1.0", меняем на 2
if [[ "$current" == *"1:1:1"* ]] || [[ "$current" == *"1.0:1.0:1.0"* ]]; then
    echo "Устанавливаю гамму 2:2:2"
    xrandr --output "$OUTPUT" --gamma 2:2:2
else
    echo "Устанавливаю гамму 1:1:1"
    xrandr --output "$OUTPUT" --gamma 1:1:1
fi