#!/bin/sh

# at a terminal
# cd ~ && sudo apt-get update && sudo apt-get install git -y && sudo apt-get upgrade -y && git clone https://github.com/jamesstorm/debian-server && cd /home/james/debian-server && chmod +x setup.sh && ./setup.sh

USERNAME="james"

# This script should be running as james

if [ "$USER" != "$USERNAME" ]
then
    echo "Run this script as $USERNAME"
    exit 0
fi

cd ~





# apt update, install things, then upgrade
sudo apt-get update 
sudo apt install \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    curl \
    wget \
    screenfetch \
    python3-pip \
    python3-venv \
    gnupg \
    lsb-release \
    mdadm \
    openssh-server \
    tmux \
    npm \
    htop \
    file \
    awscli \
    jq \
    cockpit \
    -y
sudo apt-get upgrade -y




#Github CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh -y
gh auth login
gh repo clone jamesstorm/prime /home/$USERNAME/prime
cp -R /home/$USERNAME/prime/.aws /home/$USERNAME
# need to to do this for when we need to sudo calls to AWS CLI (not that we do that much any more)
sudo cp -R /home/$USERNAME/.aws /root/




# Neovim - Nightly, baby!
#
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb .
sudo dpkg -i --force-overwrite ./nvim-linux64.deb
rm nvim-linux64.deb

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# ripgrep 
#
# Needed by The Primagen's reccos for Neovim setup that I loosley followed to create mine.
# YouTube - https://www.youtube.com/watch?v=w7i4amO_zaE
# GitHub - https://www.youtube.com/watch?v=w7i4amO_zaE
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
rm ripgrep_13.0.0_amd64.deb

# Grab my Neovim config and slam it in there.
gh repo clone jamesstorm/nvim /home/$USERNAME/.config/nvim





# Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y




# Dry 
# A terminal app for reviewing state of running containers
# 
curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
sudo chmod 755 /usr/local/bin/dry




# ZSH
# 
echo "ZSH"
sudo apt install zsh -y
chsh -s $(which zsh)
# ZSH - oh-my-zsh
echo "on-my-zsh"
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# Powerlevel10k ZSH Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
#zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# switcheroo for the .zshrc and .tmux.conf files
rm ~/.zshrc
ln prime/.zshrc .zshrc

rm ~/.tmux.conf
ln ~/prime/.tmux.conf .tmux.conf

# Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y



mkdir -p ~/bin




# DDNS with Route53
sudo cp /home/$USERNAME/prime/ddns/ddns.service /etc/systemd/system/
sudo systemctl enable ddns.service
sudo systemctl start ddns.service


# bump-up inotify so we avoid transcoding errors with plex
#   See here: https://www.reddit.com/r/PleX/comments/lzwkyc/comment/gq4xcat/?utm_source=share&utm_medium=web2x&context=3
echo "fs.inotify.max_user_watches=16384" >> /etc/sysctl.conf

