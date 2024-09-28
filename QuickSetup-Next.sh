# Install WhiteSur icon themes
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
WhiteSur-icon-theme/install.sh -a
rm -rf WhiteSur-icon-theme/

# Install McMojave and Bibata cursors
sudo mv ./cursors/* /usr/share/icons

# Install WhiteSur GTK
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
WhiteSur-gtk-theme/install.sh
sudo WhiteSur-gtk-theme/tweaks.sh -g -b "ubuntu-2.png"
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
