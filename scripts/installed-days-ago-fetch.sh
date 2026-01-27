#!/bin/bash
install_date=$(expac --timefmt='%Y-%m-%d %T' '%l' 2>/dev/null | sort | head -1 | cut -d' ' -f1)
if [ -n "$install_date" ]; then
    install_seconds=$(date -d "$install_date" +%s 2>/dev/null)
    current_seconds=$(date +%s)
    days=$(( (current_seconds - install_seconds) / 86400 ))
    echo "System installed $days days ago ($install_date)"
else
    echo "N/A"
fi