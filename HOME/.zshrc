. "$HOME/.local/bin/env"
source $HOME/.cargo/env
export DOCKER_DEFAULT_PLATFORM=linux/amd64
command -v fish > /dev/null 2>&1 && exec fish