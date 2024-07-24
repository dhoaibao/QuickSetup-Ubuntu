#!/bin/bash

set -e

# Update and upgrade the system
sudo apt-get update && sudo apt-get upgrade -y

# Remove snap and related packages
sudo rm -rf /var/cache/snapd/
sudo apt autoremove --purge snapd gnome-software-plugin-snap -y
sudo rm -rf ~/snap
sudo apt-mark hold snapd

# Install Nala and update system using Nala
sudo apt-get install -y nala
sudo nala fetch
sudo nala upgrade -y

# Install essential packages
sudo nala install -y git zsh wget nodejs npm neovim ibus-unikey gnome-tweaks gnome-shell-extension-manager flatpak gnome-software-plugin-flatpak

# Add Flathub repository
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install Monaspace font
git clone https://github.com/githubnext/monaspace.git
pushd monaspace/
bash util/install_linux.sh
popd

# Install additional fonts
pushd fonts/
sudo mv * /usr/share/fonts/truetype/
popd
sudo nala install -y ttf-mscorefonts-installer fontconfig
sudo fc-cache -f -v

# Install GNOME extensions
gnome-extensions install user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions install dash-to-dock@micxgx.gmail.com
gnome-extensions install blur-my-shell@aunetx
gnome-extensions install clipboard-indicator@tudmotu.com
gnome-extensions install hidetopbar@mathieu.bidon.ca
gnome-extensions install Vitals@CoreCoding.com

# Install WhiteSur GTK and icon themes
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
pushd WhiteSur-gtk-theme/
./install.sh -l
./tweaks.sh -F
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo ./tweaks.sh -g
popd

git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
pushd WhiteSur-icon-theme/
./install.sh -a
popd

# Install McMojave cursors
git clone https://github.com/vinceliuice/McMojave-cursors.git
pushd McMojave-cursors/
./install.sh
popd

# Install Docker Engine
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl -y
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

# Install NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k theme for Zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Install Dracula theme for GNOME Terminal
sudo nala install dconf-cli -y
git clone https://github.com/dracula/gnome-terminal
pushd gnome-terminal/
./install.sh
popd

# Install some software
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
wget https://staruml.io/api/download/releases-v6/StarUML_6.2.2_amd64.deb
wget https://zoom.us/client/6.1.5.871/zoom_amd64.deb
wget -O vscode_amd64.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
sudo nala install -y ./*.deb

# Reboot system
echo "Reboot the system to finish the setup in 5 seconds..."
sleep 5s
sudo reboot
