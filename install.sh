export password="khadas"


# Set optimization flags
export CFLAGS="-march=armv8-a -mtune=cortex-a73.cortex-a53 -mcpu=cortex-a73.cortex-a53 -mlow-precision-div -mlow-precision-sqrt -mlow-precision-recip-sqrt -O3 -g0"
export PYTHON2_EXECUTABLE=/usr/bin/python2.7
export root="$(pwd)"

# Install optimizations
echo $password | sudo -S apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev  libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev protobuf-compiler libgflags-dev libgoogle-glog-dev libblas-dev libhdf5-serial-dev liblmdb-dev libleveldb-dev liblapack-dev libsnappy-dev libprotobuf-dev libopenblas-dev libgtk2.0-dev libboost-dev libboost-all-dev libeigen3-dev libatlas-base-dev libne10-10 libne10-dev

echo $password | sudo -S apt-get install -y libneon27-dev
echo $password | sudo -S apt-get install -y libneon27-gnutls-dev

# Get Python source
wget https://www.python.org/ftp/python/3.8.1/Python-3.8.1.tar.xz
tar -xvf Python-3.8.1.tar.xz
rm -rf Python-3.8.1.tar.xz

# Configure
./Python-3.8.1/configure --prefix=$root/python3.8 --enable-optimizations --without-ensurepip --enable-shared LDFLAGS="-Wl,-rpath /usr/lib/aarch64-linux-gnu/"

# Make
make -j6
echo $password | sudo -S make -j6 install

cd $root

# Create environment
$root/python3.8/bin/python3 -m venv $root/venv

# Activate environment
source $root/venv/bin/activate

pip3 install neon


# Install numpy
pip install numpy

sleep 50000

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


cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=$root/opencv_contrib/modules -D OPENCV_ENABLE_NONFREE=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D BUILD_PYTHON_SUPPORT=ON -D WITH_OPENGL=ON -D ENABLE_NEON=ON -D ENABLE_TBB=ON -D ENABLE_IPP=ON -D WITH_OPENMP=ON -D WITH_CSTRIPES=ON -D WITH_OPENCL=ON -D USE_O3=ON -D ENABLE_FAST_MATH=ON $root/opencv


make -j6
echo $password | sudo -S make -j6 install
