# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source /etc/skel/.bashrc
source ~/.asdf/asdf.sh

# ROS1
#source /opt/ros/noetic/setup.bash

# ROS2 DDS
export ROS_DOMAIN_ID=77
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI=file:///opt/autoware/cyclonedds_config.xml
# ROS2
export RCUTILS_COLORIZED_OUTPUT=1
source /opt/ros/galactic/setup.bash
# ROS2 analysis https://tier4.github.io/CARET_doc/
# source ~/ros_ws/caret/install/local_setup.bash
# source ~/ros_ws/gsm8.iv.caret/install/local_setup.bash
# export ROS_TRACE_DIR=~/out/caret
# export LD_PRELOAD=$(readlink -f ~/ros_ws/caret/install/caret_trace/lib/libcaret.so)
# export CARET_IGNORE_NODES="/rviz*"
# export CARET_IGNORE_TOPICS="/clock:/parameter_events"

# cuda
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# C++ torch, for autoware
# If the line below is valid, pytorch instalation will be failed. import torch shows msgs "libtorch_cuda_cpp.so: undefined symbol"
export LD_LIBRARY_PATH="/usr/local/libtorch/lib:$LD_LIBRARY_PATH"

# golang
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
#export GOSUMDB=off
#export GOPROXY=direct

# luanch fish
if [ -z "$FISH_VERSION" ]; then
  command -v fish > /dev/null 2>&1 && exec fish
fi
