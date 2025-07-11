#!/bin/bash

echo "=========================="
echo "Installing App vector2025_1"

# Here is where we perform installation of scripts, services, etc.
echo " - Installing ROS packages..."

LIBPANDA_SRC=$(cat /etc/libpanda.d/libpanda_src_dir)
LIBPANDA_USER=$(cat /etc/libpanda.d/libpanda_usr)
LAUNCH_FILE=vector2025_1.launch

source /home/$LIBPANDA_USER/.bashrc

runuser -l $LIBPANDA_USER -c /etc/libpanda.d/apps/vector2025_1/installRosPackages.sh

echo "Installing vector2025_1 demo..."
# runuser -l $LIBPANDA_USER -c /etc/libpanda.d/apps/vsl/installMidVslController.sh
pushd /home/$LIBPANDA_USER/catkin_ws
runuser -l $LIBPANDA_USER -c 'source /opt/ros/noetic/setup.bash && cd catkin_ws && catkin_make'
source devel/setup.sh
rosrun robot_upstart install "vector2025_1/launch/${LAUNCH_FILE}" --user root

echo "Enabling can_to_ros startup script"
sudo systemctl daemon-reload
sudo systemctl enable vector2025_1
popd
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
