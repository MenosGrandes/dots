sudo apt purge vi* --assume-yes
sudo apt install build-essential gcc git cmake automake libtool-bin libtool ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip --assume-yes
git clone https://github.com/neovim/neovim.git
cd neovim/
make CMAKE_BUILD_TYPE=Release
sudo make install
 
