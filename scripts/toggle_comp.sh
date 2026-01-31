#!/bin/bash

if pgrep -x "picom" > /dev/null
then
    pkill xcompmgr
    notify-send "Picom" "Compositor остановлен" -t 2000
else
    if xcompmgr 2>/dev/null; then
        notify-send "Compositor" "Started" -t 2000
    else
        notify-send "Compositor" "Error!" -u critical -t 3000
    fi
fi
