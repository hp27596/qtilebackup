#!/bin/sh

# On my gpd pocket 2 the speaker sink is always listed as unavailable even though there's sound coming out from it. This script is used to manually switch sink

sink1=`pactl list sinks | grep "Sink #" | sed -n -e 's/Sink \#//p' | head -1` 


chosen=$(echo -e "[Cancel]\nSpeaker\nHeadphones\nBluetooth" | dmenu -i)

if [[ $chosen = "Speaker" ]]
then
	pactl set-default-sink $sink1
	pactl set-sink-port $sink1 analog-output-speaker
elif [[ $chosen = "Headphones" ]]
then
	pactl set-default-sink $sink1 
	pactl set-sink-port $sink1 analog-output-headphones
elif [[ $chosen = "Bluetooth" ]]
then 
	sink3=`pactl list sinks | grep "Sink #" | sed -n -e 's/Sink \#//p' | tail -1`
	pactl set-default-sink $sink3 
fi
