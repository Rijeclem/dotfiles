#!/usr/bin/env bash
# Random dual-monitor live wallpaper script
# Requires: mpvpaper

# --- CONFIG ---
DIR="$HOME/STUFF/Wallpapers/LIVE/NATURE"
MON1="DP-1"
MON2="DP-2"

# --- KILL OLD INSTANCES ---
pkill -x mpvpaper 2>/dev/null

# --- GET RANDOM FILES ---
mapfile -t FILES < <(find "$DIR" -type f -iname "*.mp4")
if [ "${#FILES[@]}" -lt 2 ]; then
  echo "Not enough videos in $DIR"
  exit 1
fi

# Shuffle and pick 2
RANDOM_FILES=($(shuf -e "${FILES[@]}" | head -n 2))
VID1="${RANDOM_FILES[0]}"
VID2="${RANDOM_FILES[1]}"

# --- APPLY WALLPAPERS ---
mpvpaper -o "loop" "$MON1" "$VID1" &
mpvpaper -o "loop" "$MON2" "$VID2" &

exit 0
