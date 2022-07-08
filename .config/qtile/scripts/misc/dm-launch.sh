#!/usr/bin/env bash

# dmenu hub script to list various scripts to run

# declare scripts description and location
declare -a options=(
    "Update Cmus Library - cmus-update.sh"
    "View keybinds (Term) - exportkeys.sh"
    "Logout - logout.sh"
    "Network (Term) - nmtui.sh"
    "Switch Audio Source - swau.sh"
    "General Info (Term) - timescript.sh"
)

# add number count
cnt=${#options[@]}
for ((i=0;i<cnt;i++)); do
    options[i]="$i. ${options[i]}"
done

# run dmenu
choice=$(printf '%s\n' "${options[@]}" | dmenu -fn 'Ubuntu Mono:pixelsize=44' -i -l 20 -p 'Choose Script:')

# run script either directly or in a terminal
if [[ "$choice" == *"Term"* ]]; then
    scr=$(printf "$choice" | awk '{print $NF}')
    alacritty -e $HOME/.config/qtile/scripts/misc/"$scr"
elif [ "$choice" ]; then
    scr=$(printf "$choice" | awk '{print $NF}')
    bash $HOME/.config/qtile/scripts/misc/"$scr"
else
    exit 1
fi
