#! /usr/bin/bash

# Do not run this script using sudo
if [[ $EUID -eq 0 ]]; then
	echo "Please do not run using sudo!"
	exit 1
fi

# Username has to be given as an argument
if [[ $# -lt 1 ]]; then
    echo "The first argument passed to the scipt should be your username."
    exit 1
fi
username=$1
homedir=/home/$username


# Intro
echo "Install script for my i3wm setup on debian."
echo "Find any infos in the README.md of this repo. https://github.com/d-hain/debian_i3_install"
echo
echo "- Find me on github: https://github.com/d-hain"
echo "- hyprland: https://i3wm.org"
echo "- debian linux: https://debian.org"
echo
echo "Press any button to install..."
read _button


# Update system with apt
sudo apt update && apt upgrade

# Setting up Brave install
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update

# Installing all packages
sudo apt install \
    brave-browser \
    rust-all \
    zsh alacritty \
    vim neovim \
    i3 i3lock \
    docker docker-compose \
    virt-manager \
    neofetch imv \
    exa btop bat ripgrep \
    brightnessctl pavucontrol bluez pamixer \
    nautilus filezilla libreoffice \
    mypaint \
    fonts-jetbrains-mono fonts-font-awesome \
    lolcat sl git \
    grim xclip slurp


# Installing wallutils
sudo apt install \
    golang imagemagick \
    libx11-dev libxcursor-dev libxmu-dev libwayland-dev \
    libxpm-dev xbitmaps libxmu-headers libheif-dev make
git clone https://github.com/xyproto/wallutils
cd wallutils
make
sudo make PREFIX=/usr/local install
cd ..

# Installing Discord
sudo curl "https://dl-canary.discordapp.net/apps/linux/0.0.169/discord-canary-0.0.169.deb" --output discord.deb
sudo apt install ./discord.deb

# Installing JetBrains Toolbox
jetbrainsfiledir=$(pwd)
wget -cO jetbrains-toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
cd /usr/bin/
sudo tar -xzf $jetbrainsfiledir/jetbrains-toolbox.tar.gz
sudo mv jetbrains-toolbox-* jetbrains-toolbox
cd $jetbrainsfiledir

# Installing Postman
postmanfiledir=$(pwd)
wget -cO postman.tar.gz "https://dl.pstmn.io/download/latest/linux_64"
cd /usr/bin/
sudo tar -xzf $postmanfiledir/postman.tar.gz
cd $postmanfiledir

# Installing Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Installing ohmyzsh plugins
zshcustom=$HOME/.oh-my-zsh/custom
git clone https://github.com/zsh-users/zsh-autosuggestions $zshcustom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $zshcustom/plugins/zsh-syntax-highlighting

# Installing packer (nvim package manager)
git clone --depth 1 git@d-hain:wbthomason/packer.nvim $homedir/.local/share/nvim/site/pack/packer/start/packer.nvim


# Configure git
echo "Configure git name and email? (y/n)"
read conf_git

if [[ $conf_git -eq "y" ]]; then
	git config --global user.name "David Hain"
	git config --global user.email "d.hain@gmx.at"

	echo "git config done."
fi


# Copying config files from https://github.com/d-hain/dotfiles
git clone --recurse-submodules https://github.com/d-hain/dotfiles

workdir=$(pwd)

# .config
sudo mv $workdir/dotfiles/.config/alacritty   $homedir/.config/alacritty
sudo mv $workdir/dotfiles/.config/nvim        $homedir/.config/nvim
sudo mv $workdir/dotfiles/.config/i3        $homedir/.config/i3
sudo mv $workdir/dotfiles/.config/i3status        $homedir/.config/i3status

sudo mv $workdir/dotfiles/.vimrc              $homedir/
sudo mv $workdir/dotfiles/.ideavimrc          $homedir/
sudo mv $workdir/dotfiles/.zshrc              $homedir/
sudo mv $workdir/dotfiles/.zsh_profile        $homedir/


# Sexy ending
clear
neofetch
