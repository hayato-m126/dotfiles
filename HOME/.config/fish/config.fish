alias bash='env FISH_VERSION=$FISH_VERSION bash'
set -q ROS_DISTRO && source /opt/ros/$ROS_DISTRO/share/rosbash/rosfish
eval (gh completion -s fish| source)
