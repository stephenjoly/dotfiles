#!/bin/bash

# Update the system
sudo pacman -Suy --noconfirm

# Install essential packages
sudo pacman -S --needed --noconfirm git neovim fastfetch zsh firefox obsidian timeshift tailscale \
  cups hplip system-config-printer sshfs bluez bluez-utils btusb syncthing chromium \
  libreoffice-fresh vlc stow remmina ripgrep bat zoxide wl-clipboard nfs-utils tree \
  nerd-fonts-complete tmux exfatprogs net-tools libheif eza resolvconf kitty lsusb \
  usbutils kiwix-desktop openvpn networkmanager-openvpn nvm python-ipykernel python-pandas \
  python-pip python-chardet python-openpyxl python-matplotlib python-xlsxwriter python-openai \
  python-nltk

# Change default shell to zsh without prompting
sudo chsh -s /usr/bin/zsh $USER

# Install AUR helper (yay) non-interactively
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm

# Install AUR packages non-interactively
yay -S --noconfirm pika-backup extension-manager visual-studio-code-bin nordvpn-bin \
  whatsapp-for-linux trayscale messenger-nativefier betterbird-bin brave-bin

