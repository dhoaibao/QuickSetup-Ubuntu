#!/bin/bash

set -e

# Update and upgrade the system
sudo dnf upgrade -y

# Install essential packages
sudo dnf install -y git zsh neofetch vlc gh wget curl nodejs npm neovim dconf-editor java-21 ibus-unikey

# Install additional fonts
sudo cp -a /run/media/dhbao/Windows/Windows/Fonts ./fonts/
sudo mv fonts/* /usr/share/fonts/
sudo fc-cache -f -v

# Install Docker Engine
sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker
sudo docker run hello-world

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Dracula theme for GNOME Terminal
sudo nala install dconf-cli -y
git clone https://github.com/dracula/gnome-terminal
gnome-terminal/install.sh
rm -rf gnome-terminal/

# Install NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Install Bun
curl -fsSL https://bun.sh/install | bash
exec /usr/bin/zsh

# Install Node via NVM
nvm install --lts
nvm install node

# Install pnpm and yarn
npm i -g pnpm yarn

# Install some software
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
wget https://staruml.io/api/download/releases-v6/StarUML-6.2.2.x86_64.rpm
sudo dnf install -y ./*.rpm
rm -rf ./*.rpm

# Activate StarUML license
git clone https://github.com/dhoaibao/activate-StarUML-license.git
sudo mv activate-StarUML-license/app.asar /opt/StarUML/resources
rm -rf activate-StarUML-license/

# Install ibus-bamboo
sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/home:lamlng/Fedora_40/home:lamlng.repo
sudo dnf install ibus-bamboo

# Install Powerlevel10k theme for Zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
