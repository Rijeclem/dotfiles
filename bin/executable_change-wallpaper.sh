#!/usr/bin/env bash

MONITOR=$1 # DP-1 or DP-2
WALLPAPER_DIR="$HOME/rad-wallpapers"

# Pick a random wallpaper
FILE=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n1)

# Start swww daemon if not running
pgrep -x swww-daemon >/dev/null || swww-daemon &

# Set wallpaper on the specified monitor
# --transition-wave expects a float (seconds)
swww img --outputs "$MONITOR" --transition-wave 0.5 "$FILE"
