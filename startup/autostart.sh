#!/bin/bash
setxkbmap eu
syncthing --no-browser &
clipmenud &
nohup ~/repos/own/snowflake/proxy/proxy ~/.snowflake.log 2>&1 &
if [[ $(ps -aux | grep dwm | wc -l) -gt 1 ]]; then
    echo "FINE"
    dunst &
    emacs --daemon &
    feh --bg-fill $HOME/Pictures/Backgrounds/currentBackground.jpg
    $HOME/.config/jalupa_config/startup/dwmBar.sh &
    # picom --experimental-backends &
    picom &
    # mpris-proxy & #allow bluetooth media control keys

    # sleep 3
    # /bin/sh -c "pulseaudio --daemonize" #fix bluetooth connection
fi
