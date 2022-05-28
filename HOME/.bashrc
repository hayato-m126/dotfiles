# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source /etc/skel/.bashrc
source $HOME/.asdf/asdf.sh

# ROS2
if [ -d "/opt/ros" ]; then
  # DDS
  ifconfig lo multicast
  export ROS_LOCALHOST_ONLY=1
  export ROS_DOMAIN_ID=77
  export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
  export CYCLONEDDS_URI=file://$HOME/.ros/cyclonedds_config.xml
  export RCUTILS_COLORIZED_OUTPUT=1

  # source
  if [ -d "/opt/ros/galactic" ]; then
    source /opt/ros/galactic/setup.bash
  elif [ -d "/opt/ros/humble" ]; then
    source /opt/ros/humble/setup.bash
  fi
  #if [ -d "$HOME/ros_ws/extension" ]; then
  #  source $HOME/ros_ws/extension/install/local_setup.bash
  #fi
  # ROS2 analysis https://tier4.github.io/CARET_doc/
  # source ~/ros_ws/caret/install/local_setup.bash
  # source ~/ros_ws/x2.caret/install/local_setup.bash
  # export ROS_TRACE_DIR=~/out/caret
  # export LD_PRELOAD=$(readlink -f ~/ros_ws/caret/install/caret_trace/lib/libcaret.so)
  # export CARET_IGNORE_NODES="/rviz*"
  # export CARET_IGNORE_TOPICS="/clock:/parameter_events"
fi

if command -v ccache > /dev/null 2>&1; then
  export CC="/usr/lib/ccache/gcc"
  export CXX="/usr/lib/ccache/g++"
fi

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
