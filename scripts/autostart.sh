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
export XDG_CURRENT_DESKTOP=gnome &
export XDG_SESSION_DESKTOP=awesome &
export GTK_USE_PORTAL=1 &
export DESKTOP_SESSION=gnome &
export DISPLAY=:0 &
systemctl --user import-environment XDG_CURRENT_DESKTOP DISPLAY &
pgrep -x Throne || Throne -silent &
pactl set-source-volume \@DEFAULT_SOURCE@ 99% &
pactl set-source-volume \@DEFAULT_SOURCE@ 100% &
pactl set-source-volume \@DEFAULT_SOURCE@ 99% &
pactl set-source-volume \@DEFAULT_SOURCE@ 100% &
pactl set-source-volume \@DEFAULT_SOURCE@ 100% &
pactl load-module module-null-sink sink_name=Discord_Audio sink_properties=device.description=Discord_Audio
# pgrep -x nvidia-settings || nvidia-settings &

# ---------- ### Programs ### ---------- #
pgrep -x steam || steam -silent &
pgrep -x Discord || /home/izunamori/Apps/Discord/Discord &

# ---------- ### Deferred ### ---------- #
sleep 3
pgrep -x AyuGram || AyuGram &
