# Install WhiteSur icon themes
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
WhiteSur-icon-theme/install.sh -a
rm -rf WhiteSur-icon-theme/

# Install McMojave and Bibata cursors
sudo mv ./cursors/* /usr/share/icons

# Install WhiteSur GTK
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
WhiteSur-gtk-theme/install.sh -l
WhiteSur-gtk-theme/tweaks.sh -F
WhiteSur-gtk-theme/tweaks.sh -f monterey
sudo flatpak override --filesystem=xdg-config/gtk-4.0
sudo WhiteSur-gtk-theme/tweaks.sh -g
rm -rf WhiteSur-gtk-theme/

# Install NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Install Bun
curl -fsSL https://bun.sh/install | bash

#Cloundflare connect
warp-cli registration new
warp-cli connect
warp-cli mode warp+doh
warp-cli registration license M9c1dp82-xR30TW25-d2T1S06U
curl https://www.cloudflare.com/cdn-cgi/trace/ 
