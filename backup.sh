#!/bin/sh

# check to see is git command line installed in this machine
IS_GIT_AVAILABLE="$(git --version)"
if [[ $IS_GIT_AVAILABLE == *"version"* ]]; then
  echo "Git is Available"
else
  echo "Git is not installed"
  exit 1
fi


## copy .config files
cp --parents -r /etc/X11/xorg.conf.d/ $HOME/qtilebackup

#cp -p -r ~/config-alacritty $HOME/dotfiles
cp -p -r ~/.config/{alacritty,bottom,btop,cmus,dunst,fcitx5,feh,'gtk-2.0','gtk-3.0',mpv,nvim,picom,qtile,ranger,dmenu-frecency,zathura} $HOME/qtilebackup/.config

cp -r ~/.doom.d/ $HOME/qtilebackup/
# cp -r ~/.fonts/ $HOME/qtilebackup/

cp /etc/{environment,pacman.conf,vconsole.conf} $HOME/qtilebackup/etc/

# copy other dot files
cp $HOME/{'.gtkrc-2.0',.vimrc,.zshrc,.xprofile,.Xresources,.tmux.conf,.ticker.yaml} $HOME/qtilebackup

# Check git status
gs="$(git status | grep -i "modified")"
# echo "${gs}"

# If there is a new change
if [[ $gs == *"modified"* ]]; then
  echo "push"
fi


# push to Github
git add -A;
git commit -m "New backup `date +'%Y-%m-%d %H:%M:%S'`";
git push origin main
