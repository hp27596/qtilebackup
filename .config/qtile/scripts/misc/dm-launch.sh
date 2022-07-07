#!/usr/bin/env bash

declare -a options=(
    "Update Cmus Library - cmus-update.sh"
    "(Term) View keybinds - exportkeys.sh"
    "Logout - logout.sh"
    "(Term) Network - nmtui.sh"
    "Switch Audio Source - swau.sh"
    "(Term) General Info - timescript.sh"
)

cnt=${#options[@]}
for ((i=0;i<cnt;i++)); do
    options[i]="$i. ${options[i]}"
    # echo "${options[i]}"
done

choice=$(printf '%s\n' "${options[@]}" | dmenu -fn 'Ubuntu Mono:pixelsize=44' -i -l 20 -p 'Choose Script:')

if [[ "$choice" == *"Term"* ]]; then
    scr=$(printf "$choice" | awk '{print $NF}')
    echo "$scr"
    alacritty -e $HOME/.config/qtile/scripts/misc/"$scr"
elif [ "$choice" ]; then
    scr=$(printf "$choice" | awk '{print $NF}')
    echo "$scr"
    bash $HOME/.config/qtile/scripts/misc/"$scr"
else
    exit 1
fi
