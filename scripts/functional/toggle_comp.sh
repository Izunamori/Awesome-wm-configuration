#!/bin/bash

if pgrep -x "picom" > /dev/null
then
    pkill picom;
    notify-send "Picom" "Stopped" -t 2000
else
    if picom --daemon --config ~/.config/awesome/.config/picom.conf 2>/dev/null; then
        notify-send "Picom" "Started" -t 2000
    else
        notify-send "Picom" "Error!" -u critical -t 3000
    fi
fi
