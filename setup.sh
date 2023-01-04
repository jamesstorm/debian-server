#!/bin/sh

# at a terminal
# cd ~ && sudo apt-get update && sudo apt-get install git -y && sudo apt-get upgrade -y && git clone https://github.com/jamesstorm/debian-server && cd ~/debian-server && chmod +x setup.sh && ./setup.sh



# this script should be running as james

if [$user != james]
then
    echo "Run this script as james"
    exit 0
fi

echo "HERE WE GO!"

cd ~

# apt update upgrade
apt-get update 
apt install apt-transport-https ca-certificates software-properties-common curl wget -y
apt-get upgrade -y

#Github CLI
echo "Github CLI"
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

read -p "Paste github token: " TOKEN
echo $TOKEN > "tokenfile.tmp"

gh auth login --with-token < tokenfile.tmp
rm tokenfile.tmp

sudo apt install wget \
screenfetch \
python3-pip \
-y

sudo cp -R /root/prime/.aws /root/
sudo cp -R /root/prime/.aws /home/james/

#neovim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb . 
sudo dpkg -i --force-overwrite ./nvim-linux64.deb

gh repo clone jamesstorm/nvim /home/james/.config


#get my nvim config
cd ~/.config
gh repo clone jamesstorm/nvim


#docker
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

#ZSH
echo "ZSH"
sudo apt install zsh -y
chsh -s $(which zsh)

#oh-my-zsh
echo "on-my-zsh"
sudo sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

screenfetch
