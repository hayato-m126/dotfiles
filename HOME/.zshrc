if [ -d "$HOME/.cargo" ]; then
  source $HOME/.cargo/env
fi
command -v fish > /dev/null 2>&1 && exec fish
