alias bash='env FISH_VERSION=$FISH_VERSION bash'

# zstd
function taz
  if test (count $argv) -ne 1
    echo "command to compress directory using zstd"
    echo "Usage: taz <dir>"
    return 1
  end

  set dir $argv[1]
  set archive "$dir.tar.zst"

  tar -I zstd -cvf $archive $dir
end
alias untaz='tar -I zstd -xvf'

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
