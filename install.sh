export password="khadas"


# Set optimization flags
export CFLAGS="-march=armv8-a -mtune=cortex-a73.cortex-a53 -mcpu=cortex-a73.cortex-a53 -mlow-precision-div -mlow-precision-sqrt -mlow-precision-recip-sqrt -O3 -g0"
export root="$(pwd)"

# Install tools
echo $password | sudo -S apt install -y gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf g++ gcc cmake git

# Install optimizations and libs
echo $password | sudo -S apt install -y build-essential libtbb2 libtbb-dev cmake git pkg-config libavcodec-dev libtbb2 libtbb-dev libdc1394-22-dev protobuf-compiler libgflags-dev libgoogle-glog-dev libblas-dev libhdf5-serial-dev liblmdb-dev libleveldb-dev gfortran libsnappy-dev libprotobuf-dev libopenblas-dev libboost-dev libboost-all-dev libeigen3-dev libatlas-base-dev libne10-10 libne10-dev python3-pip libavformat-dev libswscale-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev ibgtk2.0-dev libgtk-3-dev liblapacke-dev liblapack-dev llvm llvm-dev python3-dev python3-pip gdb

# Some python packages
pip3 install numpy numba serial pyserial requests scipy scikit-learn==0.23.2

echo $password | sudo -S apt autoremove
