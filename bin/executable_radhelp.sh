#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME/MEGA/BASENOTE/PROGRAMMING/Linux/radhelp"

INTRO_EN="$BASE_DIR/Introduction.md"
INTRO_TR="$BASE_DIR/Giriş.md"

# ask language (simple + robust)
choice=$(
    printf "English\nTürkçe\n" |
        wofi --dmenu --prompt "Manual language"
)

case "$choice" in
English)
    FILE="$INTRO_EN"
    ;;
Türkçe)
    FILE="$INTRO_TR"
    ;;
*)
    exit 0
    ;;
esac

# open nvim fullscreen
hyprctl dispatch exec "kitty -e nvim $FILE"

# give Hyprland a moment to focus the new window
sleep 0.5

# force fullscreen on the active window
hyprctl dispatch fullscreen
