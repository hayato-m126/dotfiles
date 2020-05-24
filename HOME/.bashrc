# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source /etc/skel/.bashrc

# homebrew
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# ros1
UBUNTU_VER=$(lsb_release -sc)
if [ "$UBUNTU_VER" = "focal" ]; then
    source /opt/ros/noetic/setup.bash
elif [ "$UBUNTU_VER" = "bionic" ]; then
    source /opt/ros/melodic/setup.bash
elif [ "$UBUNTU_VER" = "xenial" ]; then
    source /opt/ros/kinetic/setup.bash
fi
source ~/catkin_ws/devel/setup.bash
source ~/autoware.proj/install/setup.bash

# cuda
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# luanch fish
if [ -z "$FISH_VERSION" ]; then
  command -v fish > /dev/null 2>&1 && exec fish
fi
