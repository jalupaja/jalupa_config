#!/bin/sh

batteryToSend="1"

while true; do

    #volume
    if [ "$(amixer sget Master | awk -F "[][]" '/Left:/ { print $4 }')" = "off" ]; then
        curVolume="🔈 $(amixer sget Master | awk -F "[][]" '/Left:/ { print $2 }')"
    else
        curVolume="🔊 $(amixer sget Master | awk -F "[][]" '/Left:/ { print $2 }')"
    fi

    #date
    curDate=$(date +"%a %d.%m")
    curTime=$(date +%H:%M)

    #battery
    battery=$(cat /sys/class/power_supply/BAT0/capacity)

    if [ "$batteryToSend" -eq "1" ]; then

        if [ "$battery" -le "5" ]; then
            notify-send -u critical -a battery -t 120000 "battery low!"
            batteryToSend=0
        fi
    fi
    curBattery="🔋 $battery%"
    xsetroot -name "[$curVolume] [$curBattery] [$curDate] [$curTime] "
    sleep 2
done
