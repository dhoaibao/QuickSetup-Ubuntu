# Install WhiteSur GTK
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
WhiteSur-gtk-theme/install.sh -l
WhiteSur-gtk-theme/tweaks.sh -F
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo WhiteSur-gtk-theme/tweaks.sh -g
rm -rf WhiteSur-gtk-theme/

# Install WhiteSur icon themes
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
WhiteSur-icon-theme/install.sh -a
rm -rf WhiteSur-icon-theme/

# Install McMojave and Bibata cursors
sudo mv ./cursors/* /usr/share/icons
