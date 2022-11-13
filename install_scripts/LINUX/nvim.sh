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

NPM_PACKAGES="\
    neovim \
    pyright \
    "

    TEMP_USER=$USER
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

    curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y -qq nodejs
    sudo npm install -g $NPM_PACKAGES
    python3 -m pip install --user -q $PYTHON_PACKAGES

    cd $_
    sudo rm -rf neovim
