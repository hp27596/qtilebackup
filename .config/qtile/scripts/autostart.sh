#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}



#starting utility applications at boot time
xautolock -time 10 -locker 'betterlockscreen -l' -detectsleep -killtime 12 -killer "systemctl suspend" &

\emacs --daemon &
nextcloud &
fcitx5 &
blueman-applet &
caffeine &
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

run nuclear &

emacsclient -c -a "emacs" &
