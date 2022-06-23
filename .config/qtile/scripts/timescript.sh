#!/usr/bin/env bash

pfetch
uname -a
date
curl -m 5 "wttr.in/21.0292095,105.85247?format=Hanoi+-+%l+-+%T+|+Weather:+%C+|+Temp:+%t+|+Feels+Like:+%f+|+Humidity:+%h\n"
echo -n "Local IPv4: " && ip addr show wlan0 | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}'
echo -n "Public IPv4: " && curl -s -m 5 icanhazip.com
echo
fortune
read -n 1
