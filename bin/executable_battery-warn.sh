#!/bin/bash

BAT="/org/freedesktop/UPower/devices/battery_BAT0"
PERCENT=$(upower -i "$BAT" | awk '/percentage/ {gsub("%",""); print int($2)}')
STATE=$(upower -i "$BAT" | awk '/state/ {print $2}')

[ "$STATE" != "discharging" ] && exit 0

if [ "$PERCENT" -le 15 ]; then
    notify-send -u critical "Battery Critical" "Battery at ${PERCENT}%"
elif [ "$PERCENT" -le 25 ]; then
    notify-send -u normal "Battery Low" "Battery at ${PERCENT}%"
fi
