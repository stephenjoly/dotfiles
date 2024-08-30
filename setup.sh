#!/bin/bash

# Update the system
sudo pacman -Suy --noconfirm

# Install essential packages
sudo pacman -S --needed --noconfirm base-devel cups hplip system-config-printer sshfs bluez bluez-utils libreoffice-fresh ripgrep bat zoxide wl-clipboard nfs-utils tree exfatprogs net-tools libheif eza usbutils openvpn networkmanager-openvpn systemd-resolved

sudo pacman -S --needed --noconfirm neovim fastfetch zsh firefox obsidian timeshift tailscale syncthing chromium vlc stow remmina tmux kittykiwix-desktop lazygit

sudo pacman -S --needed --noconfirm python-ipykernel python-pandas python-pip python-chardet python-openpyxl python-matplotlib python-xlsxwriter python-openai fzf

sudo systemctl enable syncthing.service --user
sudo systemctl start syncthing.service --user

# Change default shell to zsh without prompting
sudo chsh -s /usr/bin/zsh $USER

# Install AUR helper (yay) non-interactively
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm

# Install AUR packages non-interactively
yay -S --noconfirm pika-backup visual-studio-code-bin nordvpn-bin whatsapp-for-linux betterbird-bin

# Navigate to the dotfiles directory
cd ~/dotfiles

# Run stow for each specified folder
stow kitty
stow nvim
stow tmux
stow zsh

# Setup the git stuff for the dotfiles folder
git config --global user.email "stephen.a.joly@gmail.com"
git config --global user.name "Stephen"
git branch -m main
git remote set-url origin git@github.com:stephenjoly/dotfiltes.git 


# Generate SSH key
ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
