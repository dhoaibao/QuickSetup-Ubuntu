#!/bin/bash

set -e

# Update and upgrade the system
sudo apt-get update && sudo apt-get upgrade -y

#PPA Git
sudo add-apt-repository ppa:git-core/ppa

# Install Nala and update system using Nala
sudo apt-get install -y nala
sudo nala fetch
sudo nala upgrade -y

# Install essential packages
sudo nala install -y libreoffice zsh neofetch gh wget curl nodejs npm neovim gnome-tweaks gnome-shell-extension-manager flatpak gnome-software-plugin-flatpak dconf-editor filezilla

# Add Flathub repository
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install additional fonts
sudo mv fonts/* /usr/share/fonts/truetype/
sudo fc-cache -f -v

# Install Dracula theme for GNOME Terminal
sudo nala install dconf-cli -y
git clone https://github.com/dracula/gnome-terminal
gnome-terminal/install.sh
rm -rf gnome-terminal/

# Install ibus-bamboo
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
sudo nala upgrade
sudo nala install -y ibus ibus-bamboo --install-recommends
ibus restart
# Đặt ibus-bamboo làm bộ gõ mặc định
env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"

# Set local time
timedatectl set-local-rtc 1 --adjust-system-clock

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install WhiteSur icon themes
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
WhiteSur-icon-theme/install.sh -a
rm -rf WhiteSur-icon-theme/

# Install McMojave and Bibata cursors
sudo mv ./cursors/* /usr/share/icons

# Install WhiteSur GTK
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
WhiteSur-gtk-theme/install.sh
sudo WhiteSur-gtk-theme/tweaks.sh -g -b "wallpaper.png"
rm -rf WhiteSur-gtk-theme/

# Install NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Install Bun
curl -fsSL https://bun.sh/install | bash
