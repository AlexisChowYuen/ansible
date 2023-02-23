#!/bin/bash

apt-get update -y

ufw allow 22/tcp
ufw enable

apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
apt-get update -y
sudo apt install -y ansible
