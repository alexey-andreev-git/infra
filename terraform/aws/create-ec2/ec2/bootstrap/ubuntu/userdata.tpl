#!/bin/bash

echo "Starting init script for Ubuntu"
echo "${public_key}" >> ~/.ssh/authorized_keys
echo "${public_key}" >> /home/ubuntu/.ssh/authorized_keys
sudo apt update
sudo apt install docker.io -y
sudo -H -u ubuntu sudo usermod -aG docker ubuntu
update-alternatives --install /usr/bin/python python $(ls /usr/bin/python3.*) 1
# sudo apt install git nginx build-essential apache2-utils -y
touch /tmp/init.compleate
