# DDS
ifconfig lo multicast
export ROS_LOCALHOST_ONLY=1
export ROS_DOMAIN_ID=77
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export RCUTILS_COLORIZED_OUTPUT=1
export LD_LIBRARY_PATH="/usr/local/libtorch/lib:$LD_LIBRARY_PATH"
export CYCLONEDDS_URI=file://$HOME/.ros/cyclonedds.xml

# source
if [ -d "/opt/ros/humble" ]; then
  source /opt/ros/humble/setup.bash
fi
if [ -d "/opt/ros/jazzy" ]; then
  source /opt/ros/jazzy/setup.bash
fi
