#!/bin/bash
set -x
sudo apt update -y -qq
sudo apt upgrade -y -qq
sudo apt install curl xclip build-essential ninja-build cmake git kdiff3 tmux -qq -y
bash ./installRgFZFFromSource.sh
bash ./nvim.sh $USER
pushd $(pwd)
cd git
bash install_aliases.sh
cd ../tmux
bash install_tmux.sh
cd ../python
bash virtualenvwrapper_config.sh
popd
