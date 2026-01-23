#!/bin/bash
while pgrep -x osu >/dev/null; do
    echo "1"
    sleep 1
done
echo "0"