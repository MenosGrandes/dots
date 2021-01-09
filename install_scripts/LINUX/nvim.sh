#!/bin/bash

PACKAGES="\
	git \
	curl \
	python3-dev \
	python3-pip \
	wget \
	gcc  \
	git  \
	cmake  \
	automake  \
	libtool-bin  \
	libtool  \
	ninja-build  \
	gettext  \
	libtool  \
	libtool-bin  \
	autoconf  \
	automake  \
	cmake  \
	g++  \
	pkg-config  \
	unzip  \
"

PYTHON_PACKAGES="\
	numpy \
	matplotlib \
	neovim \
	scipy\
	pandas\
	sympy\
	nose\
	flake8 \
	autopep8 \
	jedi \
	scipy \
	"

TEMP_USER=$1
USER_HOME=/home/$TEMP_USER
mkdir -p $USER_HOME/.config/nvim

echo -e "Remove vim and install build tools for nvim"
sudo apt-get -qq purge vim* --assume-yes
sudo apt-get -qq install $PACKAGES --assume-yes
echo -e "Done!"

git clone -q https://github.com/neovim/neovim.git --quiet
cd neovim/
git checkout stable
make -s CMAKE_BUILD_TYPE=Release > /dev/null
sudo make -s install >/dev/null
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && sudo apt-get install -y -qq nodejs && sudo npm install -g neovim
python3 -m pip install --user -q $PYTHON_PACKAGES
parentdir="$(dirname "$(pwd)")"
grantParentDir="$(dirname "$parentdir")"
ggParentDir="$(dirname "$grantParentDir")/vim/."
cp -a $ggParentDir $USER_HOME/.config/nvim
nvim +PlugInstall +qall
mkdir -p $USER_HOME/.config/coc/extensions
cd $_
echo '{"dependencies":{}}'> package.json
sudo npm install coc-python --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
nvim +CocUpdateSync +qall
sudo rm -rf neovim
