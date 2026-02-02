#!/usr/bin/env bash

STATE_FILE="/tmp/hypridle_prev_ws"

case "$1" in
save)
    hyprctl activeworkspace -j | jq -r '.id' >"$STATE_FILE"
    ;;
restore)
    if [[ -f "$STATE_FILE" ]]; then
        hyprctl dispatch workspace "$(cat "$STATE_FILE")"
    fi
    ;;
esac
