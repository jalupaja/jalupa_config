#!/bin/sh
setxkbmap eu
setxkbmap -option caps:escape_shifted_capslock
# setxkbmap -layout "us,de" -variant "basic,nodeadkeys" -option grp:ctrls_toggle
$HOME/.config/jalupa_config/startup/autostart.sh &
exec dwm
