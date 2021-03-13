#!/bin/bash
sudo apt update
sudo apt upgrade
sudo apt install build-essential ninja-build cmake git kdiff3 tmux fzf ripgrep -qq -y
bash ./nvim.sh $USER
bash git/install_aliases.sh
bash tmux/install_tmux.sh
bash python/virtualenvwrapper_config.sh

