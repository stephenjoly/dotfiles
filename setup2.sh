#!/bin/bash

# Function to show a flashy notification
function flashy_notify() {
  local stage=$1
  notify-send "Script Stage" "$stage" --expire-time=5000
}

# Function to wait for user confirmation
function wait_for_user() {
  read -p "Press [Enter] to continue..."
}

# Stage 1: Update the system
flashy_notify "Stage 1: Updating the system"
sudo pacman -Suy --noconfirm
wait_for_user

# Stage 2: Install essential packages
flashy_notify "Stage 2: Installing essential packages"
sudo pacman -S --needed --noconfirm cups hplip system-config-printer sshfs bluez bluez-utils libreoffice-fresh ripgrep bat zoxide wl-clipboard nfs-utils tree exfatprogs net-tools libheif eza usbutils openvpn networkmanager-openvpn
wait_for_user

# Stage 3: Install my applications
flashy_notify "Stage 3: Installing my applications"
sudo pacman -S --needed --noconfirm neovim fastfetch zsh firefox obsidian timeshift tailscale syncthing chromium vlc stow remmina tmux kitty kiwix-desktop lazygit
wait_for_user

# Stage 4: Install python packages
flashy_notify "Stage 4: Installing Python packages"
sudo pacman -S --needed --noconfirm python-ipykernel python-pandas python-pip python-chardet python-openpyxl python-matplotlib python-xlsxwriter python-openai fzf
wait_for_user

# Stage 5: Enable key services
flashy_notify "Stage 5: Enabling key services"
sudo systemctl enable syncthing.service --user
sudo systemctl start syncthing.service --user

sudo systemctl enable tailscaled
sudo systemctl start tailscaled
wait_for_user

# Stage 6: Change default shell to zsh without prompting
flashy_notify "Stage 6: Changing default shell to zsh"
sudo chsh -s /usr/bin/zsh $USER
wait_for_user

# Stage 7: Install AUR helper (yay) non-interactively
flashy_notify "Stage 7: Installing AUR helper (yay)"
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
cd ..
wait_for_user

# Stage 8: Install AUR packages non-interactively
flashy_notify "Stage 8: Installing AUR packages"
yay -S --noconfirm pika-backup visual-studio-code-bin nordvpn-bin whatsapp-for-linux betterbird-bin
wait_for_user

# Stage 9: Setup the git stuff for the dotfiles folder
flashy_notify "Stage 9: Setting up Git for dotfiles"
git config --global user.email "stephen.a.joly@gmail.com"
git config --global user.name "Stephen"
git branch -m main
git remote set-url origin git@github.com:stephenjoly/dotfiles.git
wait_for_user

# Stage 10: Generate SSH key if there isn't one already
flashy_notify "Stage 10: Generating SSH key"
ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
wait_for_user

# Stage 11: Run stow for dotfiles
flashy_notify "Stage 11: Running stow for dotfiles"
cd ~/dotfiles
stow kitty nvim tmux zsh
wait_for_user

echo -e "\033[1;32mScript completed successfully!\033[0m"

