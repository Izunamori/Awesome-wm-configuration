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
sudo pacman -Syyu thunar steam fish ttf-jetbrains-mono ntfs-3g pavucontrol lib32-nvidia-utils gvfs nwg-look qt6ct kvantum polkit-gnome xcolor pipewire pipewire-pulse file-roller zip unzip btop flatpak obs-studio jp2a discord vscode telegram-desktop gparted telegram-desktop gparted thunar-archive-plugin polkit-gnome xclip --noconfirm
yay -S ttf-font-awesome ttf-jetbrains-mono-nerd tela-circle-icon-theme polychromatic teamspeak opentabletdriver clipit adw-gtk-theme-git kvantum-theme-libadwaita-git --noconfirm
```
