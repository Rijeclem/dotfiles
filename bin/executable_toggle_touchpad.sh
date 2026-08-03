#!/bin/bash

DEVICE="synps/2-synaptics-touchpad"
STATE_FILE="$HOME/.cache/touchpad.state"

mkdir -p "$HOME/.cache"

[[ -f "$STATE_FILE" ]] || echo 1 >"$STATE_FILE"

STATE=$(<"$STATE_FILE")

if [[ "$STATE" == "1" ]]; then
    ENABLED=false
    NEW_STATE=0
    MESSAGE="Touchpad disabled"
else
    ENABLED=true
    NEW_STATE=1
    MESSAGE="Touchpad enabled"
fi

hyprctl eval "hl.device({
    name = \"$DEVICE\",
    enabled = $ENABLED,
})"

echo "$NEW_STATE" >"$STATE_FILE"
notify-send "$MESSAGE"
