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

apt-get purge vim* --assume-yes
apt-get install $PACKAGES --assume-yes

git clone https://github.com/neovim/neovim.git
cd neovim/
git checkout stable
make CMAKE_BUILD_TYPE=Release
make install
curl -sL https://deb.nodesource.com/setup_13.x | bash - && apt-get install -y -qq nodejs && npm install -g neovim 
python3 -m pip install --user $PYTHON_PACKAGES
mkdir -p ~/.config/nvim 
mv  ~/dots/vim/init.vim ~/.config/nvim/
mv  ~/dots/vim/coc-settings.json ~/.config/nvim/
nvim +PlugInstall +qall
mkdir -p /root/.config/coc/extensions
cd /root/.config/coc/extensions
echo '{"dependencies":{}}'> package.json
npm install coc-python --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
nvim +CocUpdateSync +qall
rm -rf neovim
