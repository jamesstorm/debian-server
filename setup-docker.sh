#!/bin/sh

# this script is just for developeing and testing server set-up using docker. It basically replicates what the Debian installer will do:
#   - create user with sudo
# See setup.sh for the script that should be runon bare iron 

# need to run this first manually
# cd ~ && apt-get update && apt-get install git -y && apt-get upgrade -y && git clone https://github.com/jamesstorm/debian-server && cd ~/debian-server && chmod +x setup-docker.sh && ./setup-docker.sh

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White


echo "${Green}Hello, Simulated Debian Installer${Color_Off}"

read -p "Enter username: " USERNAME
read -p "Enter a password for $USERNAME " PASSWD

apt-get install sudo

useradd -m -p $(openssl passwd -crypt $PASSWD) $USERNAME
usermod -aG sudo $USERNAME

rm -rf ~/debian-server

echo "Now run: ${Yellow}su -l $USERNAME${Color_Off} and do the other things."











