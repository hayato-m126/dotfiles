if [ -f "$HOME/.secrets/env.sh" ]; then
  source $HOME/.secrets/env.sh
fi
# rust
if [ -f "$HOME/.cargo/env" ]; then
  source $HOME/.cargo/env
fi
if [ -z "$FISH_VERSION" ]; then
  command -v fish > /dev/null 2>&1 && exec fish
fi
