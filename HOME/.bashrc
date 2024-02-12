# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source /etc/skel/.bashrc
source $HOME/.cargo/env
source $HOME/.rye/env

# ROS2
if [ -d "/opt/ros" ]; then
  # DDS
  ifconfig lo multicast
  export ROS_LOCALHOST_ONLY=1
  export ROS_DOMAIN_ID=77
  export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
  export RCUTILS_COLORIZED_OUTPUT=1

  # source
  if [ -d "/opt/ros/humble" ]; then
    export CYCLONEDDS_URI=file://$HOME/.ros/cyclonedds_humble.xml
    source /opt/ros/humble/setup.bash
  fi
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

# python, poetry
# https://stackoverflow.com/questions/74438817/poetry-failed-to-unlock-the-collection
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

# mojo
# export MODULAR_HOME="$HOME/.modular"
# export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

# luanch fish
if [ -z "$FISH_VERSION" ]; then
  command -v fish > /dev/null 2>&1 && exec fish
fi
