#!/bin/bash

echo "=========================="
echo "Removing App vector2025_1"


LIBPANDA_USER=$(cat /etc/libpanda.d/libpanda_usr)

# Disable the installed services:
echo " - Disabling startup scripts..."
systemctl disable vector2025_1

# Here is where we remove scripts, services, etc.
echo " - Removing scripts..."
cd
if [ "x"`systemctl list-units | grep -c vector2025_1.service` = "x1" ]; then
    echo "Uninstalling vector2025_1.service"

    source /home/$LIBPANDA_USER/catkin_ws/devel/setup.bash
    rosrun robot_upstart uninstall vector2025_1
fi

systemctl daemon-reload # if needed
