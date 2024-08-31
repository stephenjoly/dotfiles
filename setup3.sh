#!/bin/bash

# Define log file
LOGFILE="script_log.txt"

# Function to show a flashy notification
function flashy_notify() {
  local stage=$1
  notify-send "Script Stage" "$stage" --expire-time=5000
}

# Function to wait for user confirmation
function wait_for_user() {
  echo -e "\n#########################################################"
  read -p "Press [Enter] to continue..."
  echo -e "#########################################################\n"
}

# Function to notify completion of each stage
function notify_completion() {
  local stage=$1
  echo -e "\n#########################################################"
  echo "$stage is complete."
  echo -e "#########################################################\n"
}

# Redirect all output to log file
exec > >(tee -a "$LOGFILE") 2>&1

# Log start time
echo "Script started at $(date)" | tee -a "$LOGFILE"

# Stage 1: Update the system
flashy_notify "Stage 1: Updating the system"
wait_for_user
sudo pacman -Suy --noconfirm
notify_completion "Stage 1"

# Stage 2: Install essential packages
flashy_notify "Stage 2: Installing essential packages"
wait_for_user
sudo pacman -S --needed --noconfirm cups hplip system-config-printer sshfs bluez bluez-utils libreoffice-fresh ripgrep bat zoxide wl-clipboard nfs-utils tree exfatprogs net-tools libheif eza usbutils openvpn networkmanager-openvpn freerdp fzf
notify_completion "Stage 2"

# Stage 3: Install my applications
flashy_notify "Stage 3: Installing my applications"
wait_for_user
sudo pacman -S --needed --noconfirm neovim fastfetch zsh firefox obsidian timeshift tailscale syncthing chromium vlc stow remmina tmux kitty kiwix-desktop lazygit
notify_completion "Stage 3"

# Stage 4: Install python packages
flashy_notify "Stage 4: Installing Python packages"
wait_for_user
sudo pacman -S --needed --noconfirm python-ipykernel python-pandas python-pip python-chardet python-openpyxl python-matplotlib python-xlsxwriter python-openai

notify_completion "Stage 4"

# Stage 5: Enable key services
flashy_notify "Stage 5: Enabling key services"
wait_for_user
sudo systemctl enable syncthing.service --user
sudo systemctl start syncthing.service --user
sudo systemctl enable tailscaled
sudo systemctl start tailscaled
notify_completion "Stage 5"

# Stage 6: Change default shell to zsh without prompting
flashy_notify "Stage 6: Changing default shell to zsh"
wait_for_user
sudo chsh -s /usr/bin/zsh $USER
notify_completion "Stage 6"

# Stage 7: Install AUR helper (yay) non-interactively
flashy_notify "Stage 7: Installing AUR helper (yay)"
wait_for_user
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
cd ..
notify_completion "Stage 7"

# Stage 8: Install AUR packages non-interactively
flashy_notify "Stage 8: Installing AUR packages"
wait_for_user
yay -S --noconfirm pika-backup visual-studio-code-bin nordvpn-bin whatsapp-for-linux betterbird-bin
notify_completion "Stage 8"

# Stage 9: Setup the git stuff for the dotfiles folder
flashy_notify "Stage 9: Setting up Git for dotfiles"
wait_for_user
cd ~/dotfiles
git config --global user.email "stephen.a.joly@gmail.com"
git config --global user.name "Stephen"
git branch -m main
git remote set-url origin git@github.com:stephenjoly/dotfiles.git
notify_completion "Stage 9"

# Stage 10: Generate SSH key if there isn't one already
flashy_notify "Stage 10: Generating SSH key"
wait_for_user
ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
notify_completion "Stage 10"

# Stage 11: Run stow for dotfiles
flashy_notify "Stage 11: Running stow for dotfiles"
wait_for_user
stow kitty nvim tmux zsh
notify_completion "Stage 11"

# Log end time
echo "Script completed at $(date)" | tee -a "$LOGFILE"

echo -e "\033[1;32mScript completed successfully!\033[0m" | tee -a "$LOGFILE"

