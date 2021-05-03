# Set $SHELL for venv in VSCode
set SHELL (which fish)

# colcon
#alias colcon='__colcon_find_workspace_dir > /dev/null && cd (__colcon_find_workspace_dir); command colcon'

# ROS
if set -q ROS_DISTRO
  if [ "$ROS_VERSION" = "1" ]
    set -q ROS_DISTRO && source /opt/ros/$ROS_DISTRO/share/rosbash/rosfish
  else
    register-python-argcomplete --shell fish ros2 | source
  end
end

# Created by `pipx` on 2021-04-15 00:28:02
set PATH $PATH /home/hyt/.local/bin
