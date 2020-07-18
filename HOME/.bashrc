# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source /etc/skel/.bashrc

# homebrew
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# ros
if [ -d "/opt/ros" ]; then
  # ros1
  if [ -d "/opt/ros/noetic" ]; then
    source /opt/ros/noetic/setup.bash
  elif [ -d "/opt/ros/melodic" ]; then
    source /opt/ros/melodic/setup.bash
  elif [ -d "/opt/ros/kinetic" ]; then
    source /opt/ros/kinetic/setup.bash
  fi
fi

# cuda
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

if [ -d $HOME/.anyenv ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

test -d $HOME/.anyenv/envs/goenv && export PATH=$PATH:$GOPATH/bin

# luanch fish
if [ -z "$FISH_VERSION" ]; then
 command -v fish > /dev/null 2>&1 && exec fish
fi
