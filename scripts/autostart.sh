#!/bin/sh

### Монитор ### -----------------------------------------------------------------------
xrandr --output DP-0 --mode 2560x1440 --rate 164.83 &


### Раскладки ### ---------------------------------------------------------------------
setxkbmap -layout us,ru -variant -option grp:alt_shift_toggle,terminate:ctrl_alt_cksp &
lxsession &


### прочее ### ------------------------------------------------------------------------
telegram-desktop &
clipit &
xcompmgr &
# steam -silent &
# discord --start-minimized &
xset m 1 1 &
otd-daemon &
flatpak run com.github.wwmm.easyeffects --gapplication-service &
pactl set-source-volume \@DEFAULT_SOURCE@ 99% &
pactl set-source-volume \@DEFAULT_SOURCE@ 100% &
pactl set-source-volume \@DEFAULT_SOURCE@ 99% &
pactl set-source-volume \@DEFAULT_SOURCE@ 100% &
pactl set-source-volume \@DEFAULT_SOURCE@ 100% &

