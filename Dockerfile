ARG tag=11.1.1-cudnn8-devel-ubuntu20.04
FROM nvidia/cuda:$tag
ENV ROOTDIR=/home
ENV CUDA_HOME=/usr/local/cuda-11.1
ENV DOCK_REPOSIT=RecoderProxy-DockerBuild

WORKDIR $ROOTDIR

# install nvidia video encoder
RUN mkdir -p $DOCK_REPOSIT
#ADD Video_Codec_SDK_12.0.16 $DOCK_REPOSIT/Video_Codec_SDK_12.0.16
ADD gst-build $DOCK_REPOSIT/gst-build
RUN chmod -R +x $DOCK_REPOSIT/gst-build

# install gstreamer
RUN bash $DOCK_REPOSIT/gst-build/build-gst.sh $DOCK_REPOSIT

# install software
ENTRYPOINT bash
