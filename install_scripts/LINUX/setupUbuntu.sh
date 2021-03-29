#!/bin/bash
set -x
sudo apt update -y -qq
sudo apt upgrade -y -qq
sudo apt install build-essential ninja-build cmake git kdiff3 tmux fzf ripgrep -qq -y
bash ./nvim.sh $USER
pushd $(pwd)
cd git
bash install_aliases.sh
cd ../tmux
bash install_tmux.sh
cd ../python
bash python/virtualenvwrapper_config.sh
popd
