alias bash='env FISH_VERSION=$FISH_VERSION bash'
alias zsh='env FISH_VERSION=$FISH_VERSION zsh'

# Set $SHELL for venv in VSCode
set SHELL (which fish)

# ROS
if set -q ROS_DISTRO
  register-python-argcomplete --shell fish ros2 | source
end

# mise
if test -f ~/.local/bin/mise
    ~/.local/bin/mise activate fish | source
end

# pnpm
set -gx PNPM_HOME "/home/hyt/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

if command -q zoxide
    zoxide init fish | source
end

abbr -a -- untaz 'tar -I zstd -xvf'
