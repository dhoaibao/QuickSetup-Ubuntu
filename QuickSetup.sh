#!/bin/bash

set -e

# Refresh Snap
sudo snap refresh

# Update and upgrade the system
sudo apt-get update && sudo apt-get upgrade -y

#PPA Git
sudo add-apt-repository ppa:git-core/ppa

# Install Nala and update system using Nala
sudo apt-get install -y nala
sudo nala fetch
sudo nala upgrade -y

# Install essential packages
sudo nala install -y libreoffice zsh neofetch gh wget curl nodejs npm neovim gnome-tweaks gnome-shell-extension-manager flatpak gnome-software-plugin-flatpak openjdk-21-jdk dconf-editor ibus-unikey filezilla

# Add Flathub repository
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Add cloudflare gpg key
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

# Add this repo to your apt repositories
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list

# Install Cloundflare
sudo nala upgrade && sudo nala install -y cloudflare-warp

# Install additional fonts
sudo mv fonts/* /usr/share/fonts/truetype/
sudo nala install -y ttf-mscorefonts-installer fontconfig
sudo fc-cache -f -v

# Install Docker Engine
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
# Add Docker's official GPG key:
sudo nala upgrade
sudo nala install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo nala upgrade -y
sudo nala install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install Dracula theme for GNOME Terminal
sudo nala install dconf-cli -y
git clone https://github.com/dracula/gnome-terminal
gnome-terminal/install.sh
rm -rf gnome-terminal/

# Install Spotify
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo nala upgrade && sudo nala install spotify-client -y

# Install some software
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget https://staruml.io/api/download/releases-v6/StarUML_6.2.2_amd64.deb
sudo nala install -y ./*.deb
rm -rf ./*.deb

# Activate StarUML license
git clone https://github.com/dhoaibao/activate-StarUML-license.git
sudo mv activate-StarUML-license/app.asar /opt/StarUML/resources
rm -rf activate-StarUML-license/

# Install ibus-bamboo
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
sudo nala upgrade
sudo nala install -y ibus ibus-bamboo --install-recommends
ibus restart
# Đặt ibus-bamboo làm bộ gõ mặc định
env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"

# Set local time
timedatectl set-local-rtc 1 --adjust-system-clock

# Install Powerlevel10k theme for Zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
