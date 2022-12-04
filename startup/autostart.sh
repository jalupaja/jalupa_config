#!/bin/sh
dunst &
clipmenud &
emacs --daemon &
feh --bg-fill $HOME/Pictures/Backgrounds/currentBackground.jpg
$HOME/.config/jalupa_config/startup/dwmBar.sh &
picom --experimental-backends &
syncthing --no-browser &
nohup /home/jakob/repos/own/snowflake/proxy/proxy /home/jakob/.snowflake.log 2>&1 &
# mpris-proxy & #allow bluetooth media control keys

# sleep 3
# /bin/sh -c "pulseaudio --daemonize" #fix bluetooth connection
