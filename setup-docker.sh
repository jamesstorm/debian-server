#!/bin/sh

# this script is just for developeing and testing server set-up using docker. It basically replicates what the Debian installer will do:
#   - create user with sudo
# See setup.sh for the script that should be runon bare iron 

# need to run this first manually
# cd ~ && apt-get update && apt-get install git -y && apt-get upgrade -y && git clone https://github.com/jamesstorm/debian-server && cd ~/debian-server && chmod +x setup.sh && ./setup.sh


echo "Hello, Simulated Debian Installer"

read -p "Enter username: : " USERNAME

read -p "Enter a password for $USERNAME: " PASSWD


#create a user then collect a passwd

useradd -m -p $(openssl passwd -crypt $PASSWD) $USERNAME
usermod -aG sudo $USERNAME









