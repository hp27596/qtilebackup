#!/bin/bash

# Simple script to handle a DIY shutdown menu. When run you should see a bunch of options (shutdown, reboot etc.)
#
# Requirements:
# - dmenu
# - systemd

chosen=$(echo -e "[Cancel]\n1. Logout\n2. Shutdown\n3. Reboot\n4. Suspend" | dmenu -fn 'Ubuntu Mono:pixelsize=44' -i)

if [[ $chosen = "4. Suspend" ]]; then
	systemctl suspend
elif [[ $chosen = "1. Logout" ]]; then
	echo 'shutdown()' | qtile shell
elif [[ $chosen = "2. Shutdown" ]]; then
	systemctl poweroff
elif [[ $chosen = "3. Reboot" ]]; then
	systemctl reboot
fi
