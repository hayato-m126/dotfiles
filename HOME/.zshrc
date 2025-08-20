if [ -d "$HOME/.cargo" ]; then
  source $HOME/.cargo/env
fi
if [ -f "$HOME/.secrets/env.sh" ]; then
  source $HOME/.secrets/env.sh
fi
command -v fish > /dev/null 2>&1 && exec fish
