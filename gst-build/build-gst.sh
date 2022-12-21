export GST_ROOT=/home
export BRANCH=1.18.5
cd $GST_ROOT
git clone https://github.com/GStreamer/gst-build
cd gst-build
git checkout $BRANCH
# configure gstreamer
meson build
# enable nvidia-cuda encoder for gstreamer-plugin-bad
cp -f /home/RecoderProxy-DockerBuild/gst-build/meson_options.txt $GST_ROOT/gst-build/gst-plugins-bad/meson_options.txt

# build and install gstreamer 
cd $GST_ROOT/gst-build
ninja -C build install

ldconfig

# verify gstreamer installation
gst-launch-1.0 --gst-version

# verify nvidida video encoder and decoder
gst-inspect-1.0 nvh264enc
gst-inspect-1.0 nvh264dec