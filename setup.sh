#!/bin/sh

echo "Hello, Debain Server"

# need to run this first manually
# cd ~ && apt-get update && apt-get install git curl -y && apt-get upgrade -y && git clone https://github.com/jamesstorm/debian-server && cd ~/debian-server && chmod +x setup.sh && ./setup.sh

# apt update upgrade
apt-get update 
apt install apt-transport-https ca-certificates curl software-properties-common -y
apt-get upgrade -y

#create a user then collect a passwd
#adduser --disabled-password --gecos "" james
#echo "james ALL=PASSWD: ALL" > /etc/ers.d/james
#passwd

#Github CLI
echo "Github CLI"
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& apt update \
&& apt install gh -y

gh auth login

cd ~

gh repo clone jamesstorm/prime

cd ~/prime/debian

chmod +x setup.sh
./setup.sh






