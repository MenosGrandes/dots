sudo apt install -y pkg-config git cmake build-essential nasm wget python3-setuptools libusb-1.0-0-dev  python3-dev python3-pip python3-numpy python3-scipy libglew-dev libtbb-dev

# ffmpeg >= 3.2
sudo apt install -y libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev ffmpeg x264 x265 libportaudio2 portaudio19-dev

# OpenCV >= 3 + Eigen
sudo apt install -y python3-opencv libopencv-dev libeigen3-dev


wget -O libjpeg-turbo.tar.gz https://sourceforge.net/projects/libjpeg-turbo/files/1.5.1/libjpeg-turbo-1.5.1.tar.gz/download
tar xvzf libjpeg-turbo.tar.gz
cd libjpeg-turbo-1.5.1
./configure --enable-static=no --prefix=/usr/local
sudo make install
sudo ldconfig



git clone https://github.com/pupil-labs/libuvc
cd libuvc
mkdir build
cd build
cmake ..
make && sudo make install

echo 'SUBSYSTEM=="usb",  ENV{DEVTYPE}=="usb_device", GROUP="plugdev", MODE="0664"' | sudo tee /etc/udev/rules.d/10-libuvc.rules > /dev/null
sudo udevadm trigger

echo 'Add SSH KEY TO https://gitlab.com/MenosGrandes/pupillabupgrades if not added!'

cd ~/Desktop
git clone git@gitlab.com:MenosGrandes/pupillabupgrades.git mg_pupil

cd mg_pupil

git checkout task/mg/updateForkPupilLab

mkvirtualenv pupil_labs_mg
workon pupil_labs_mg

python -m pip install --upgrade pip wheel
python3 -m pip install -r requirements.txt

