#!/bin/bash

sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update -qq
sudo apt install golang-go -qq -y
go install github.com/mattn/efm-langserver@latest
echo 'export GOPATH="/home/$USER/go/bin" ' >> ~/.bashrc
echo 'export PATH="$PATH:$GOPATH" ' >> ~/.bashrc
source /home/$USER/.bashrc
