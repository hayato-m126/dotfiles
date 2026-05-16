export ROS_LOCALHOST_ONLY=1
export ROS_DOMAIN_ID=77
export RCUTILS_COLORIZED_OUTPUT=1
export CYCLONEDDS_URI=file://$HOME/.ros/cyclonedds.xml

# DDS
#ifconfig lo multicast

# autoware ansible
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export CCACHE_DIR="$HOME/.ccache"
export CC="/usr/lib/ccache/gcc"
export CXX="/usr/lib/ccache/g++"
export CMAKE_PREFIX_PATH="/opt/acados:${CMAKE_PREFIX_PATH}"
export ACADOS_SOURCE_DIR="/opt/acados"
export LD_LIBRARY_PATH="/opt/acados/lib:${LD_LIBRARY_PATH}"

# source
if [ -d "/opt/ros/humble" ]; then
  source /opt/ros/humble/setup.bash
fi
if [ -d "/opt/ros/jazzy" ]; then
  source /opt/ros/jazzy/setup.bash
fi
