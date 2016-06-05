#!/usr/bin/env bash
sudo apt-get -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible-1.9
sudo apt-get -y update
sudo apt-get -y install ansible