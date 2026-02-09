#!/bin/sh

# ---------- ### Monitors ### ---------- #
xrandr \
  --output DP-2 \
      --primary \
      --mode 2560x1440 \
      --rate 164.83 \
      --pos 0x0 \
      --rotate normal \
  --output HDMI-0 \
      --mode 1920x1080 \
      --rate 165.00 \
      --pos -1920x280 \
      --rotate normal &


# ---------- ###  Other   ### ---------- #
timedatectl &
pgrep -x clipit || clipit &
picom --config ~/.config/awesome/.config/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
otd-daemon &


# ---------- ### Programs ### ---------- #
sleep 5 && AyuGram &
pgrep -x steam || steam -silent &
/home/izunamori/Documents/Apps/Discord/Discord # --start-minimized &