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

gitca() {
  git reset --hard HEAD && \
  git clean -df && \
  git submodule foreach git reset --hard HEAD && \
  git submodule foreach git clean -df
}

conflict() {
  OUTPUT_FILE="merge_conflict_$(date +%Y%m%d_%H%M%S).md"
  CONFLICTED_FILES="$(git diff --name-only --diff-filter=U)"
  if [[ -z "$CONFLICTED_FILES" ]]; then
    CONFLICTED_COUNT=0
  else
    CONFLICTED_COUNT="$(printf '%s\n' "$CONFLICTED_FILES" | wc -l)"
  fi

  echo "# Merge Conflict Resolution" > "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  echo "Date: $(date)" >> "$OUTPUT_FILE"
  echo "Branch: $(git branch --show-current)" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"

  echo "Conflicted files: $CONFLICTED_COUNT" >> "$OUTPUT_FILE"

  echo "## Conflicted Files" >> "$OUTPUT_FILE"
  echo '```' >> "$OUTPUT_FILE"
  printf '%s\n' "$CONFLICTED_FILES" >> "$OUTPUT_FILE"
  echo '```' >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"

  echo "## Conflict Details" >> "$OUTPUT_FILE"
  while IFS= read -r file; do
    [[ -z "$file" ]] && continue
    echo "### $file" >> "$OUTPUT_FILE"
    echo '```diff' >> "$OUTPUT_FILE"
    git diff "$file" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
  done <<< "$CONFLICTED_FILES"

  echo "Saved to: $OUTPUT_FILE"
}

__fzf_history_search() {
    local result
    result=$(history | tac | awk '{$1=""; print substr($0,2)}' | fzf) &&
    READLINE_LINE="$result"
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-r": __fzf_history_search'


__ghq_cd() {
  # ghqで管理しているリポジトリ一覧からfzfで選択し、そのディレクトリへ移動
  local repo_dir
  repo_dir=$(ghq list -p | fzf)
  if [[ -n "$repo_dir" ]]; then
    cd "$repo_dir" || return 1
  fi
}
bind -x '"\C-g": __ghq_cd'
