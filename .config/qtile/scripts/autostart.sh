#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}



#starting utility applications at boot time
xautolock -time 10 -locker 'betterlockscreen -l' -detectsleep -killtime 15 -killer "systemctl suspend" &

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
feh --bg-fill ~/.config/qtile/scripts/1099421.png

sleep 1
alacritty &
run emacsclient -c -a "emacs" &
run google-chrome-stable --enable-features=VaapiVideoDecoder,VaapiVideoEncoder --disable-features=UseChromeOSDirectVideoDecoder --gtk-version=4 &

sleep 1
tmux kill-server &
alacritty --class tmux,tmux -e tmux &

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
