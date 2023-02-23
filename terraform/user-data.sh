#!/bin/bash

apt-get update -y
apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
apt-get update -y
sudo apt install -y ansible
