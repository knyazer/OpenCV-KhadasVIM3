export password="khadas"


# Set optimization flags
export CFLAGS="-march=armv8-a -mtune=cortex-a73.cortex-a53 -mcpu=cortex-a73.cortex-a53 -mlow-precision-div -mlow-precision-sqrt -mlow-precision-recip-sqrt -O3 -g0"
export PYTHON2_EXECUTABLE=/usr/bin/python2.7
export root="$(pwd)"

# Install tools
echo $password | sudo -S apt install -y gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf g++ gcc cmake git

# Install optimizations
echo $password | sudo -S apt install -y build-essential cmake git pkg-config libavcodec-dev libtbb2 libtbb-dev libdc1394-22-dev protobuf-compiler libgflags-dev libgoogle-glog-dev libblas-dev libhdf5-serial-dev liblmdb-dev libleveldb-dev gfortran libsnappy-dev libprotobuf-dev libopenblas-dev libboost-dev libboost-all-dev libeigen3-dev libatlas-base-dev libne10-10 libne10-dev python3-pip libavformat-dev libswscale-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev libneon27-dev libneon27-gnutls-dev libgtk2.0-dev libgtk-3-dev liblapacke-dev liblapack-dev python3-dev

echo $password | sudo -S apt autoremove

# Install neon
pip3 install neon

# Install cython (for numpy)
pip3 install cython

# Install numpy
pip3 install numpy

# Remove old files
rm -rf opencv*

# Downloading and unpacking opencv
wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.8.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.8.zip
unzip opencv.zip
unzip opencv_contrib.zip
mv opencv-3.4.8 opencv
mv opencv_contrib-3.4.8 opencv_contrib

# Delete archives
rm -rf opencv*.zip

mkdir $root/opencv/build
cd $root/opencv/build

# Config opencv
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=$root/opencv_contrib/modules -D OPENCV_ENABLE_NONFREE=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D BUILD_PYTHON_SUPPORT=ON -D WITH_OPENGL=ON -D ENABLE_NEON=ON -D ENABLE_TBB=ON -D BUILD_TBB=ON -D WITH_TBB=ON -D ENABLE_IPP=ON -D WITH_OPENMP=ON -D WITH_CSTRIPES=ON -D WITH_OPENCL=ON -D USE_O3=ON -D ENABLE_FAST_MATH=ON $root/opencv

# Make
make -j6
echo $password | sudo -S make -j6 install
