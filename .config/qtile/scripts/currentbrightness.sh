#!/usr/bin/env bash
notify-send -t 2000 "$(brightnessctl | grep Current)"
