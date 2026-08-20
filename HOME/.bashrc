# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  source /etc/skel/.bashrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS specific settings
  if [ -f /etc/bashrc ]; then
    source /etc/bashrc
  fi
fi

if [[ -d /run/WSL ]]; then
    export BROWSER="'/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'"
fi

source "$HOME/.bash_aliases"
source "$HOME/.bash_functions"

if command -v ccache > /dev/null 2>&1; then
  export CC="/usr/lib/ccache/gcc"
  export CXX="/usr/lib/ccache/g++"
fi

# cuda
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# if remote access, change Ghostty background color
if [ -n "$SSH_CONNECTION" ]; then
    printf '\e]11;#204022\a'
fi

if test -f ~/.local/bin/mise; then
  eval "$(~/.local/bin/mise activate bash)"
fi

if command -v jj > /dev/null 2>&1; then
  source <(jj util completion bash)
fi

[ -f "$HOME/.secrets/env.sh" ] && source "$HOME/.secrets/env.sh"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -d "/opt/ros" ] && source "$HOME/.ros/setup.sh"
