# Install WhiteSur GTK
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
WhiteSur-gtk-theme/install.sh -l
WhiteSur-gtk-theme/tweaks.sh -F
WhiteSur-gtk-theme/tweaks.sh -f monterey
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo WhiteSur-gtk-theme/tweaks.sh -g
rm -rf WhiteSur-gtk-theme/
