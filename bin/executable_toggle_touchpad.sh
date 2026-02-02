#!/bin/bash

DEVICE="synps/2-synaptics-touchpad"
STATE_FILE="$HOME/.cache/touchpad.state"

mkdir -p "$HOME/.cache"

# default to enabled if state file doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo 1 >"$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

if [ "$STATE" = "1" ]; then
    hyprctl keyword "device[$DEVICE]:enabled" false
    echo 0 >"$STATE_FILE"
    notify-send "Touchpad disabled"
else
    hyprctl keyword "device[$DEVICE]:enabled" true
    echo 1 >"$STATE_FILE"
    notify-send "Touchpad enabled"
fi
