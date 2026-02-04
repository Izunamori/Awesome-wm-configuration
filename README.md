## yay
```bash
sudo pacman -S --needed base-devel git
mkdir Git
cd Git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## My pkgs
```bash
sudo pacman -Syyu dmenu rofi satty reflector thunar steam tumbler ffmpegthumbs xorg-xset lsd ffmpegthumbnailer maim mpv fish ttf-jetbrains-mono playerctl ntfs-3g pavucontrol lib32-nvidia-utils gvfs nwg-look polkit-gnome xcolor pipewire tela-circle-icon-theme-black pipewire-pulse engrampa zip unzip btop flatpak obs-studio jp2a discord gparted telegram-desktop gparted thunar-archive-plugin xclip aria2 --noconfirm
yay -S ttf-font-awesome ttf-jetbrains-mono-nerd polychromatic ttf-monocraft teamspeak opentabletdriver clipit xkb-switch --noconfirm
```

## OTD
```bash
systemctl --user enable opentabletdriver.service --now
```

## Mouse sensitivity & keyboard settings
```bash
echo -e 'Section "InputClass"
                       Identifier "libinput mouse"
                       MatchIsPointer "on"
                       MatchDriver "libinput"
                       Option "AccelProfile" "flat"
                       Option "AccelSpeed" "0.3"
                   EndSection' | sudo tee /etc/X11/xorg.conf.d/40-libinput.conf > /dev/null
```
```bash
echo -e 'Section "InputClass"
                       Identifier "system-keyboard"
                       MatchIsKeyboard "on"
                       Option "XkbLayout" "us,ru"
                       Option "XkbModel" "pc105"
                       Option "XkbOptions" "grp:alt_shift_toggle,terminate:ctrl_alt_bksp"
                   EndSection' | sudo tee /etc/X11/xorg.conf.d/00-keyboard.conf > /dev/null
```

## Soft link for ~/Pictures & ~/Videos
```bash
mv ~/Pictures ~/Pictures.backup
ln -s /mnt/HDD/pictures_linux ~/Pictures
mv ~/Videos ~/Videos.backup
ln -s /mnt/HDD/videos_linux ~/Videos
```

## setup xinitrc
```bash
cat > ~/.xinitrc << 'EOF'
#!/bin/sh

(sleep 1 && awesome-client 'awesome.restart()') &

exec awesome
EOF

chmod +x ~/.xinitrc
```

## Osu contest wallpapers
https://drive.google.com/drive/folders/1Nm4zB7QWDt6u4piY9MBQwlfVnTq9eos8

## Installing graphite GTK  theme with tweaks
```bash
mkdir ~/Git
cd ~/Git
git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
~/Git/Graphite-gtk-theme/install.sh -t default -c dark -s compact -l --tweaks black
```

## Sync configs with repository
```bash
rm -r ~/.config/fish; ln -s ~/.config/awesome/.config/fish/ ~/.config/fish
rm -r ~/.config/Thunar; ln -s ~/.config/awesome/.config/Thunar/ ~/.config/Thunar
rm -r ~/.config/pipewire; ln -s ~/.config/awesome/.config/pipewire/ ~/.config/pipewire
rm -r ~/.config/MangoHud; ln -s ~/.config/awesome/.config/MangoHud/ ~/.config/MangoHud
rm -r ~/.config/btop; ln -s ~/.config/awesome/.config/btop/ ~/.config/btop
rm -r ~/.config/alacritty; ln -s ~/.config/awesome/.config/alacritty/ ~/.config/alacritty
rm -r ~/.config/rofi; ln -s ~/.config/awesome/.config/rofi/ ~/.config/rofi
```