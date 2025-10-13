# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

source /etc/skel/.bashrc

if [[ -d /run/WSL ]]; then
    export BROWSER="'/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'"
fi

# rust
if [ -f "$HOME/.cargo/env" ]; then
  source $HOME/.cargo/env
fi

# ROS2
if [ -d "/opt/ros" ]; then
  source $HOME/.ros/setup.sh
fi

if command -v ccache > /dev/null 2>&1; then
  export CC="/usr/lib/ccache/gcc"
  export CXX="/usr/lib/ccache/g++"
fi

# cuda
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

if [ -f "$HOME/.secrets/env.sh" ]; then
  source $HOME/.secrets/env.sh
fi

# if remote access, change Ghostty background color
if [ -n "$SSH_CONNECTION" ]; then
    printf '\e]11;#204022\a'
fi

# launch fish
if [ -z "$FISH_VERSION" ] && [ "$USE_DEVCONTAINER" != "true" ]; then
  command -v fish > /dev/null 2>&1 && exec fish
fi

# When not using fish, activate mise in bash.
if test -f ~/.local/bin/mise; then
  eval "$(~/.local/bin/mise activate bash)"
fi

# zstd
taz() {
  if [ $# -ne 1 ]; then
    echo "command to compress directory using zstd"
    echo "Usage: taz <dir>"
    return 1
  fi

  dir="$1"
  archive="${dir}.tar.zst"
  tar -I zstd -cvf "$archive" "$dir"
}

alias untaz='tar -I zstd -xvf'

# bazel
alias bazel="bazelisk"
if command -v zoxide > /dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

alias gitca="
  git reset --hard HEAD && \
  git clean -df && \
  git submodule foreach git reset --hard HEAD && \
  git submodule foreach git clean -df
"
