#!/bin/sh
picom --experimental-backends &
dunst &
clipmenud &
feh --bg-fill $HOME/Pictures/Backgrounds/currentBackground.jpg
$HOME/.config/jalupa_config/home/dwmBar.sh &
mpris-proxy & #allow bluetooth media control keys

sleep 3
/bin/sh -c "pulseaudio --daemonize" #fix bluetooth connection
