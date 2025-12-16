## Установка yay
```bash
sudo pacman -S --needed base-devel git
mkdir Git
cd Git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
## Мои пакеты
```bash
sudo pacman -Syyu thunar steam tumbler ffmpegthumbs maim mpv fish ttf-jetbrains-mono playerctl ntfs-3g pavucontrol lib32-nvidia-utils gvfs nwg-look qt6ct kvantum polkit-gnome xcolor pipewire pipewire-pulse file-roller zip unzip btop flatpak obs-studio jp2a discord vscode telegram-desktop gparted telegram-desktop gparted thunar-archive-plugin polkit-gnome xclip --noconfirm
yay -S ttf-font-awesome ttf-jetbrains-mono-nerd tela-circle-icon-theme polychromatic ttf-monocraft teamspeak opentabletdriver clipit adw-gtk-theme-git kvantum-theme-libadwaita-git --noconfirm
```
## OTD
```bash
systemctl --user enable opentabletdriver.service --now
```
## Настройки чувствительности мыши
```bash
    sudo nano /etc/X11/xorg.conf.d/40-libinput.conf
```
```bash
    Section "InputClass"
        Identifier "libinput mouse"
        MatchIsPointer "on"
        MatchDriver "libinput"
        Option "AccelProfile" "flat"
        Option "AccelSpeed" "0.3"
    EndSection
```
