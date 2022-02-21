setxkbmap -option caps:escape_shifted_capslock
setxkbmap -layout "us,de" -variant "basic,nodeadkeys" -option grp:ctrls_toggle
picom --experimental-backends &
dunst &
clipmenud &
feh --bg-fill $HOME/Pictures/Backgrounds/currentBackground.jpg
exec dwm
