sudo apt-get update && sudo apt-get upgrade -y

sudo rm -rf /var/cache/snapd/
sudo apt autoremove --purge snapd gnome-software-plugin-snap -y
sudo rm -fr ~/snap
sudo apt-mark hold snapd

sudo apt-get install -y nala
sudo nala fetch
sudo nala upgrade -y
sudo nala install -y git zsh nodejs npm neovim gnome-tweaks gnome-shell-extension-manager flatpak gnome-software-plugin-flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

sudo nala install dconf-cli -y
git clone https://github.com/dracula/gnome-terminal
cd gnome-terminal/
./install.sh
cd ..

git clone https://github.com/githubnext/monaspace.git
cd monaspace/
bash util/install_linux.sh
cd ..

cd fonts/
sudo mv * /usr/share/fonts/truetype/
cd ..
sudo nala install -y ttf-mscorefonts-installer
sudo nala install -y fontconfig
sudo fc-cache -f -v

gnome-extensions install user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions install dash-to-dock@micxgx.gmail.com
gnome-extensions install blur-my-shell@aunetx
gnome-extensions install clipboard-indicator@tudmotu.com
gnome-extensions install hidetopbar@mathieu.bidon.ca
gnome-extensions install Vitals@CoreCoding.com

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme/
./install.sh -l
./tweaks.sh -F
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo ./tweaks.sh -g
cd ..

git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme/
./install.sh -a
cd ..

git clone https://github.com/vinceliuice/McMojave-cursors.git
cd McMojave-cursors/
./install.sh
cd ..

echo "Reboot the system to finish the setup in 5 seconds..."
sleep 5s
reboot
