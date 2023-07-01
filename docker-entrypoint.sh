#!/bin/bash
set -e
source /root/.bashrc
source "/opt/ros/noetic/setup.bash"             #<--- TODO: change to your ROS version
# CONTAINER_INITIALIZED="CONTAINER_INITIALIZED_PLACEHOLDER"

CONTAINER_INITIALIZED="CONTAINER_INITIALIZED_PLACEHOLDER"
if [ ! -e $CONTAINER_INITIALIZED ]; then
    touch $CONTAINER_INITIALIZED
    echo "-- First container startup --"
    catkin init
    #catkin config
    sh -c 'echo "yaml https://raw.githubusercontent.com/basler/pylon-ros-camera/master/pylon_camera/rosdep/pylon_sdk.yaml" > /etc/ros/rosdep/sources.list.d/30-pylon_camera.list' && rosdep update && rosdep install --from-paths . --ignore-src --rosdistro=$ROS_DISTRO -y && catkin clean -y 
    catkin build
else
    echo "-- Not first container startup --"
fi
source "/ws/devel/setup.bash"

exec "$@"