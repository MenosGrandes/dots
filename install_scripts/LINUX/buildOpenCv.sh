#!/bin/bash
VERSION=$1
set -x
cd ~/
mkdir OPENCV
cd OPENCV
cwd=$(pwd)
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout $VERSION
cd $cwd
git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout $VERSION
cd $cwd
cd opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_OPENGL="1" -D WITH_QT="1" -D PYTHON2_EXECUTABLE:FILEPATH="" -D BUILD_EXAMPLES="1" -D OPENCV_EXTRA_MODULES_PATH:PATH="~/OPENCV/opencv_contrib/modules" -D WITH_TBB="1" -D BUILD_TBB="1" -D WITH_CUDA="1" -D CUDA_FAST_MATH="1" -D OPENCV_ENABLE_NONFREE="1" -D PYTHON2_PACKAGES_PATH:PATH="" -D INSTALL_PYTHON_EXAMPLES="1" -D PYTHON3_INCLUDE_DIR2:PATH="" -D PYTHON2_NUMPY_INCLUDE_DIRS:PATH="" ..
make -j$(nproc)
sudo make install
sudo ldconfig
