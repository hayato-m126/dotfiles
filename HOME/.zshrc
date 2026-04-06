if [ -f "$HOME/.secrets/env.sh" ]; then
  source $HOME/.secrets/env.sh
fi
# rust
if [ -f "$HOME/.cargo/env" ]; then
  source $HOME/.cargo/env
fi

# Added by Antigravity
export PATH="/Users/hyt/.antigravity/antigravity/bin:$PATH"

