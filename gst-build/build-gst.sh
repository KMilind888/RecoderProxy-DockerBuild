#!/usr/bin/bash
export GST_ROOT=/home
export DOCK_REPOSIT=/home/$1
export BRANCH=1.18.5

echo "install last git version"
apt-get update -y 
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
apt-get install software-properties-common -y
add-apt-repository ppa:git-core/ppa -y
apt update -y
apt install git -y
git --version

echo "Installing dependencies for gstreamer"
apt-get install build-essential dpkg-dev flex bison autotools-dev automake \
      liborc-dev autopoint libtool gtk-doc-tools yasm libgstreamer1.0-dev \
      libxv-dev libasound2-dev libtheora-dev libogg-dev libvorbis-dev \
      libbz2-dev libv4l-dev libvpx-dev libjack-jackd2-dev libsoup2.4-dev libpulse-dev \
      faad libfaad-dev libfaac-dev libgl1-mesa-dev libgles2-mesa-dev \
      libx264-dev libmad0-dev python-dev python3-dev -y
mv /usr/bin/python /usr/bin/python_backup
ln -s /usr/bin/python3 /usr/bin/python
python --version
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
python -m pip install --upgrade pip
pip --version
apt remove meson
python3 -m pip install meson
meson --version
apt install ninja-build
echo "successfully installed all dependencies"

echo "install nvidia video codec"
cd $DOCK_REPOSIT/Video_Codec_SDK_12.0.16
cp -rf Interface/*.h $CUDA_HOME/include
cp -rf Lib/linux/stubs/x86_64/* $CUDA_HOME/lib64/stubs

echo "build gstreamer $BRANCH"
cd $GST_ROOT
git clone https://github.com/GStreamer/gst-build
cd gst-build
git checkout $BRANCH
# configure gstreamer
meson build
# enable nvidia-cuda encoder for gstreamer-plugin-bad
cp -f /home/RecoderProxy-DockerBuild/gst-build/meson_options.txt $GST_ROOT/gst-build/gst-plugins-bad/meson_options.txt

# build and install gstreamer 
echo "build gstreamer"
cd $GST_ROOT/gst-build
ninja -C build install
ldconfig

echo "completed gst-build. verify installation"
gst-launch-1.0 --gst-version
