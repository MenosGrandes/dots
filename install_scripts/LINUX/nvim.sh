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

apt-get -qq purge vim* --assume-yes
apt-get -qq install $PACKAGES --assume-yes

git clone -q https://github.com/neovim/neovim.git $USER_HOME/dots
cd neovim/
git checkout stable
make -s CMAKE_BUILD_TYPE=Release
make -s install
curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt-get install -y -qq nodejs && npm install -g neovim
python3 -m pip install --user -q $PYTHON_PACKAGES
mv -t $USER_HOME/.config/nvim/ $USER_HOME/dots/vim/*
nvim +PlugInstall +qall
mkdir -p /root/.config/coc/extensions # why is it root?...
cd /root/.config/coc/extensions #same as above
echo '{"dependencies":{}}'> package.json
npm install coc-python --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
nvim +CocUpdateSync +qall
rm -rf neovim
