#!/bin/sh
picom --experimental-backends &
dunst &
clipmenud &
emacs --daemon
feh --bg-fill $HOME/Pictures/Backgrounds/currentBackground.jpg
$HOME/.config/jalupa_config/startup/dwmBar.sh &
mpris-proxy & #allow bluetooth media control keys

sleep 3
/bin/sh -c "pulseaudio --daemonize" #fix bluetooth connection
