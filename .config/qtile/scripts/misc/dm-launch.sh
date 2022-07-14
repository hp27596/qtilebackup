#!/usr/bin/env bash

# dmenu hub script to list various scripts to run

# declare scripts description and location
declare -a options=(
    "Kill Process - dm-killprocess.sh"
    "Misc Search (Synonym, etc) - dm-miscsearch.sh"
    "Update Cmus Library - cmus-update.sh"
    "View Keybinds (Term) - exportkeys.sh"
    "Logout Prompt - dm-logout.sh"
    "Connect to Network (Term) - nmtui.sh"
    "Switch Audio Source - dm-switchaudio.sh"
    "General Info (Term) - timescript.sh"
    "Backup Dotfiles (Term) - qtilebu.sh"
    "Open Password Manager - dm-passmenu.sh"
    "Open Clean Disk Utility (Term) - ncdu"
    "Word Autocompletion And Suggestion - dm-autocomplete.sh"
)

# add number count
cnt=${#options[@]}
for ((i=0;i<cnt;i++)); do
    options[i]="$i. ${options[i]}"
done

# run dmenu
choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 20 -p 'Choose Script:')

# run script either directly or in a terminal
if [[ "$choice" == *"Term"* ]]; then
    scr=$(printf "$choice" | awk '{print $NF}')
    if [[ "$choice" == *".sh"* ]]; then
        alacritty -e $HOME/.config/qtile/scripts/misc/"$scr"
    else
        alacritty -e $scr
    fi
elif [ "$choice" ]; then
    scr=$(printf "$choice" | awk '{print $NF}')
    if [[ "$choice" == *".sh"* ]]; then
        bash $HOME/.config/qtile/scripts/misc/"$scr"
    else
        bash $scr
    fi
else
    exit 1
fi
