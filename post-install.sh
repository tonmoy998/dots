sudo apt install zsh git neofetch curl wget screenkey font-manager obs-studio luajit lua5.4 pulseaudio pavucontrol yt-dlp vlc wl-clipborad vlc fuse ntfs-3g thunar ranger chafa kitty cava vis feh ranger sway swaylock i3 polybar waybar rofi mariadb-common mariadb-server mariadb-client dunst wf-recorder scrot xclip phpmyadmin -y  
echo "Adding my wifi driver ..."
sudo add-apt-repository ppa:kelebek333/kablosuz
sudo apt-get update
sudo apt install rtl8188fu-dkms
sudo add-apt-repository universe
sudo apt-get update
sudo apt install libfuse2
echo "Installing powerlvl 10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo "Setting npm"
mkdir ~/.npm-global 
npm config set prefix '~/.npm-global'
