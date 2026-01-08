#!/bin/bash

STATE="$HOME/.cache/hypr-mirror.state"

if [[ -f "$STATE" ]]; then
    MODE="NORMAL"
    rm "$STATE"

    # Disable first (important)
    hyprctl keyword monitor "DP-2,disable"

    # Normal (extended) layout
    hyprctl keyword monitor "DP-1,1920x1080@144,0x0,1"
    hyprctl keyword monitor "DP-2,1920x1080@60,0x-1080,1"

else
    MODE="MIRROR"
    touch "$STATE"

    # Disable first to avoid breakage
    hyprctl keyword monitor "DP-2,disable"

    # Mirror DP-1 → DP-2
    hyprctl keyword monitor "DP-1,1920x1080@144,0x0,1"
    hyprctl keyword monitor "DP-2,1920x1080@60,auto,1,mirror,DP-1"
fi

notify-send "Hyprland Display" "Switched to $MODE mode"
