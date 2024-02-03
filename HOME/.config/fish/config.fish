# Set $SHELL for venv in VSCode
set SHELL (which fish)

# ROS
if set -q ROS_DISTRO
  register-python-argcomplete --shell fish ros2 | source
end

set PATH $PATH /home/hyt/.local/bin
~/.local/bin/mise activate fish | source
