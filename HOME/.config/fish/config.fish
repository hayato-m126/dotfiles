alias bash='env FISH_VERSION=$FISH_VERSION bash'
# open current directory in Cursor
alias cur='~/AppImage/Cursor.AppImage . > /dev/null 2>&1 & disown'


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
