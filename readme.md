# Task description
This repository contains a dockerfile to build a docker image of video recorder and proxy server software. 
[RecoderProxy server software](https://github.com/KMilind888/GstreamProxyServer) requests to install nvidia video encoder/decoder plugin at gstreamer. \
To build a gstreamer with nvidia video encoder plugin, nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04 has been used as a base docker image. \
If you need to use other base docker image, you can modify it at Docker file before building a docker image. 

# How to buid docker image

```
git clone git@github.com:KMilind888/RecoderProxy-DockerBuild.git
cd RecoderProxy-DockerBuild.git
docker build -t gst-docker .
```

# Use docker image in Kubernetes

Once you succesfully build a docker image by the above command, gstreaer-18.5 with nvidia video encoder plugin will be installed in it. \
Then you can install the video recoder and proxy server software from [here](https://github.com/KMilind888/GstreamProxyServer).
You can find all kubernetes resource files(YAML files) from [kubernetes](./kubernetes) folder. 






