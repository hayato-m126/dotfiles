. "$HOME/.local/bin/env"
if [ -d "$HOME/.cargo" ]; then
  source $HOME/.cargo/env
fi
export DOCKER_DEFAULT_PLATFORM=linux/amd64
command -v fish > /dev/null 2>&1 && exec fish