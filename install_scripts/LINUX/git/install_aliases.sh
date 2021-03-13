#!/bin/bash
mkdir -p ~/.config/git
cp .gitconfig.aliases ~/.config/git
git config --global include.path "~/.config/git/.gitconfig.aliases"
