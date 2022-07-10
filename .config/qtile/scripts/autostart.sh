#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}



#starting utility applications at boot time
xautolock -time 10 -locker 'betterlockscreen -l' -detectsleep -killtime 12 -killer "systemctl suspend" &

emacs --daemon &
nextcloud &
# lxsession &
# run nm-applet &
# run pamac-tray &
# numlockx on &
fcitx5 &
blueman-applet &
caffeine &
#flameshot &
#picom --config $HOME/.config/picom/picom.conf &
picom --config ~/.config/picom/picom.conf --experimental-backends &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
dunst &
clipmenud &
feh --bg-fill ~/.config/qtile/1099421.png

sleep 2
alacritty &
run google-chrome-stable --enable-features=VaapiVideoDecoder,VaapiVideoEncoder --disable-features=UseChromeOSDirectVideoDecoder --gtk-version=4 &

sleep 1
tmux kill-server &
alacritty --class tmux,tmux -e tmux &

python ~/pyscripts/nucleartoast.py &

run emacsclient -c -a "emacs" &
   #starting user applications at boot time
# run volumeicon &
#run discord &
#nitrogen --random --set-zoom-fill &
#run caffeine -a &
#run vivaldi-stable &
#run firefox &
#run thunar &
#run dropbox &
#run insync start &
#run spotify &
#run atom &
#run telegram-desktop &
