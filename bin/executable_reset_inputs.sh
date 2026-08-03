#!/bin/bash

notify-send -t 2000 -u critical "Resetting inputs" "Please wait"

# Run USB reset script as sudo without password
sudo ~/bin/reset_usb_controller.sh

notify-send "Resetting xremap" "keyremapper"
sudo systemctl restart xremap
sleep 2

notify-send "Inputs successfully reset!" "You can now use your PC"
