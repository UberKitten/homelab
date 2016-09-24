#!/bin/bash

# Easy way to run script:
# su
# apt-get install curl
# bash <(curl -L -s https://github.com/T3hUb3rK1tten/homelab/raw/master/homelab-setup.sh)

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt-get -y install curl sudo openssh-server

rm -Rf /home/astra/.ssh
mkdir /home/astra/.ssh
curl -L -o /home/astra/.ssh/authorized_keys https://github.com/T3hUb3rK1tten/homelab/raw/master/authorized_keys
chown -R astra:astra /home/astra/.ssh
chmod -R 700 /home/astra/.ssh
chmod 600 /home/astra/.ssh/authorized_keys

curl -L -o /etc/sudoers.d/astra-sudo https://github.com/T3hUb3rK1tten/homelab/raw/master/astra-sudo
chmod 440 /etc/sudoers.d/astra-sudo

curl -L -o /etc/ssh/sshd_config https://github.com/T3hUb3rK1tten/homelab/raw/master/sshd_config
chmod 644 /etc/ssh/sshd_config
service sshd reload
