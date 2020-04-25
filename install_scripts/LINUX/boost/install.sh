wget https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz
tar -zxvf boost_1_72_0.tar.gz
cd boost_1_72_0/
#Python version
./bootstrap.sh install --with-libraries=all --with-toolset=gcc --with-python=/usr/bin/python3.8
sudo ./b2 -a -q install --with=all -j$(nproc) --with-python --debug-configuration
#Cpp version
./bootstrap.sh install --with-libraries=all --with-toolset=gcc
sudo ./b2 -a -q install --with=all -j$(nproc) --debug-configuration
sudo ldconfig
cd ..
#Make Python TEST
mkdir build
cd build
cmake ..
make
make test
