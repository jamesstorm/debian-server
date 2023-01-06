#!/bin/sh

# at a terminal
# cd ~ && sudo apt-get update && sudo apt-get install git -y && sudo apt-get upgrade -y && git clone https://github.com/jamesstorm/debian-server && cd /home/james/debian-server && chmod +x setup.sh && ./setup.sh



# this script should be running as james

if [$user != james]
then
    echo "Run this script as james"
    exit 0
fi

echo "HERE WE GO!"

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
    -y
sudo apt-get upgrade -y

#Github CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh -y

gh auth login

gh repo clone jamesstorm/prime /home/james/prime

# need to to do this for when we need to sudo calls to AWS CLI (not that we do that much any more)
sudo cp -R /hame/james/.aws /root/

#neovim - Nightly
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb .
sudo dpkg -i --force-overwrite ./nvim-linux64.deb
rm nvim-linux64.deb

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
rm ripgrep_13.0.0_amd64.deb


gh repo clone jamesstorm/nvim /home/james/.config/nvim

#docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

#Dry
curl -sSf https://moncho.github.io/dry/dryup.sh | sudo sh
sudo chmod 755 /usr/local/bin/dryup


#ZSH
echo "ZSH"
sudo apt install zsh -y
chsh -s $(which zsh)

#oh-my-zsh
echo "on-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Powerlevel10k ZSH Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc


# do a screenfetch at all zsh session starts for james
echo "screenfetch" > /home/james/.zshenv

screenfetch
