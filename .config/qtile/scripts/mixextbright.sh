#!/usr/bin/env bash

currbase=$(brightnessctl | grep Current | cut -f3 -d " ")


if [[ "$1" == "up" ]]
then
    if [[ $currbase == 100 ]]
    then
        bash 'extbright.sh' up
    else
        brightnessctl s +10%
    fi
elif [[ "$1" == "down" ]]
then
    if [[ $currbase == 0 ]]
    then
        bash 'extbright.sh' down
    else
        brightnessctl s 10%-
    fi
fi
