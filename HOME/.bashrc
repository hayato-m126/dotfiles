# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source /etc/skel/.bashrc
source ~/.asdf/asdf.sh

# ROS1
#source /opt/ros/noetic/setup.bash

# ROS2
source /opt/ros/foxy/setup.bash

export RCUTILS_COLORIZED_OUTPUT=1

# DDS setting
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CYCLONEDDS_URI=file:///opt/autoware/cyclonedds_config.xml
export AW_ROS2_USE_SIM_TIME=true

# cuda
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# golang
export GOPATH=$HOME/go

# luanch fish
if [ -z "$FISH_VERSION" ]; then
  command -v fish > /dev/null 2>&1 && exec fish
fi
