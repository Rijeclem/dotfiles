#!/usr/bin/env bash

DIR="$HOME/bin/swappyshot"
mkdir -p "$DIR"

# Full path for the screenshot
FILE="$DIR/lastshot.png"

# Export HYPRSHOT_DIR so Hyprshot saves here
export HYPRSHOT_DIR="$DIR"

# Take a frozen region screenshot directly into lastshot.png
hyprshot -m region -z -f "lastshot.png"

# Exit if screenshot failed for some reason
[ ! -f "$FILE" ] && exit 0

# Open in Swappy for annotation
swappy -f "$FILE"
