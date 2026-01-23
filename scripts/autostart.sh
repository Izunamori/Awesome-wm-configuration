#!/bin/sh

### Монитор ### -----------------------------------------------------------------------
#xrandr --output DP-0 --mode 2560x1440 --rate 164.83 &

# Указываем сначала DP-0, потом HDMI-0
xrandr \
  --output HDMI-0 --mode 1920x1080 --rate 165.00 --pos -1920x280 --rotate normal \
  --output DP-0 --primary --mode 2560x1440 --rate 164.83 --pos 0x0 --rotate normal &
 #xrandr --output HDMI-0 --mode 1920x1080 --pos 2560x672 --rotate normal &

### Раскладки ### ---------------------------------------------------------------------
# setxkbmap -layout us,ru -variant -option grp:alt_shift_toggle,terminate:ctrl_alt_cksp &
lxsession &


### прочее ### ------------------------------------------------------------------------
# Telegram &
AyuGram &
/usr/share/applications/yandexmusic.desktop
pgrep -x clipit || clipit &
# xcompmgr &
picom & 
# steam -silent &
/home/izunamori/Documents/Apps/Discord/Discord # --start-minimized &
# vesktop &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xset m 1 1 &
otd-daemon &
# flatpak run com.github.wwmm.easyeffects --gapplication-service &
pactl set-source-volume \@DEFAULT_SOURCE@ 99% &
pactl set-source-volume \@DEFAULT_SOURCE@ 100% &
pactl set-source-volume \@DEFAULT_SOURCE@ 99% &
pactl set-source-volume \@DEFAULT_SOURCE@ 100% &
pactl set-source-volume \@DEFAULT_SOURCE@ 100% &

__GL_SYNC_TO_VBLANK=0
GL_SYNC_DISPLAY_DEVICE=DP-0 
vblank_mode=0

export ELECTRON_EXTRA_FLAGS="--disable-gpu-vsync"
export ELECTRON_ENABLE_GPU_VSYNC=false

export GOOGLE_CHROME_FLAGS="--disable-gpu-vsync"