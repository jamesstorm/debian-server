#!/bin/sh

echo "Hello, Debain Server"

# need to run this first manually
# apt-get update && apt-get install git curl -y && apt-get upgrade -y
# git clone https://github.com/jamesstorm/debian-server



# apt update upgrade
apt-get update 
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
apt-get upgrade -y

#create a user then collect a passwd
adduser --disabled-password --gecos "" james
echo "james ALL=PASSWD: ALL" > /etc/sudoers.d/james
passwd

#Github CLI
echo "Github CLI"
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

gh auth login

su james

