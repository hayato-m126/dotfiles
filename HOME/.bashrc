# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source /etc/skel/.bashrc

# homebrew
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# ros1
# source /opt/ros/noetic/setup.bash

# ros2
source /opt/ros/foxy/setup.bash

# cuda
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# anyenv
command -v anyenv > /dev/null 2>&1 && eval "$(anyenv init -)"

# go
test -d $HOME/.anyenv/envs/goenv && export PATH=$PATH:$GOPATH/bin

# gh completion
eval "$(gh completion -s bash)"

# luanch fish
if [ -z "$FISH_VERSION" ]; then
  command -v fish > /dev/null 2>&1 && exec fish
fi
