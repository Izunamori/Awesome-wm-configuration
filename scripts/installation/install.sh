#!/bin/sh

sudo pacman -S git --noconfirm
cd ~/.config/
git clone https://github.com/Izunamori/Awesome-wm-configuration.git
mv -r Awesome-wm-configuration awesome
cp -r ~/.config ~/.config.bak
mv -r ~/.config/awesome/.config/ ~/.config
echo "настройки применены и создана резервная копия директории .config в домашней директории"

sleep 2

# Power saving settings for monitors
echo 'xset dpms 600 900 1200 && xset +dpms' >> ~/.xprofile
echo 'настройки энергосбережения для мониторов применены'

sleep 2

# Mouse settings
echo -e 'Section "InputClass"
                       Identifier "libinput mouse"
                       MatchIsPointer "on"
                       MatchDriver "libinput"
                       Option "AccelProfile" "flat"
                       Option "AccelSpeed" "0.3"
                   EndSection' | sudo tee /etc/X11/xorg.conf.d/40-libinput.conf > /dev/null
echo "настройки мыши применены"

sleep 2

# Keyboard settings
echo -e 'Section "InputClass"
                       Identifier "system-keyboard"
                       MatchIsKeyboard "on"
                       Option "XkbLayout" "us,ru"
                       Option "XkbModel" "pc105"
                       Option "XkbOptions" "grp:alt_shift_toggle,terminate:ctrl_alt_bksp"
                   EndSection' | sudo tee /etc/X11/xorg.conf.d/00-keyboard.conf > /dev/null
echo "настройки клавиатуры применены"

sleep 2

# Installing graphite GTK theme with tweaks
cd
mkdir ~/Git
cd ~/Git
git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
~/Git/Graphite-gtk-theme/install.sh -t default -c dark -s compact -l --tweaks black
echo "Тема установлена"

sleep 2

# yay
sudo pacman -S --needed base-devel git
mkdir Git
cd Git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
echo "yay установлен"

sleep 2

# Packages
sudo pacman -Syyu satty thunar steam tumbler ffmpegthumbs xorg-xset lsd ffmpegthumbnailer maim mpv fish ttf-jetbrains-mono playerctl ntfs-3g pavucontrol lib32-nvidia-utils gvfs nwg-look polkit-gnome xcolor pipewire pipewire-pulse engrampa zip unzip btop flatpak obs-studio jp2a discord gparted telegram-desktop gparted thunar-archive-plugin xclip aria2 --noconfirm
yay -S ttf-font-awesome ttf-jetbrains-mono-nerd tela-circle-icon-theme polychromatic ttf-monocraft teamspeak opentabletdriver clipit --noconfirm

echo "установка завершена"
sleep 1
echo "нажмите любую клавишу для продолжения..."
read -p " "