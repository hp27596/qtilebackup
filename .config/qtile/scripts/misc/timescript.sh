#!/usr/bin/env bash
upcount=$(mktemp)
ispeed=$(mktemp)

(checkupdates | wc -l) > "${upcount}" &
(speedtest-cli | grep load:) > "${ispeed}" &

pfetch
# uname -a
date
curl -m 5 "wttr.in/21.0292095,105.85247?format=Hanoi+-+%l+-+%T+|+Weather:+%C+|+Temp:+%t+|+Feels+Like:+%f+|+Humidity:+%h\n"
echo
echo -n "Local IPv4: " && ip addr show wlan0 | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}'
echo -n "Public IPv4: " && curl -s -m 5 icanhazip.com
echo

echo "Checking Arch Linux Updates..."
wait
echo "---------"
echo "$(<$upcount) available updates"
echo
# fortune
echo "Checking internet speed..."
wait
echo "---------"
echo "$(<$ispeed)"

echo
echo -n "Press any key to exit."
read -n 1
