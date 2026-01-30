#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for changing blurs on the fly

STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

if [ "${STATE}" == "3" ]; then
	hyprctl keyword decoration:blur:size 0
	hyprctl keyword decoration:blur:passes 0
 	notify-send -e -u low -i "" "Increased Transparency"
elif [ "${STATE}" == "0" ]; then
	hyprctl keyword decoration:blur:size 5
	hyprctl keyword decoration:blur:passes 4
	notify-send -e -u low -i "" "Decreased Transparency"
else
	hyprctl keyword decoration:blur:size 3
	hyprctl keyword decoration:blur:passes 3
  	notify-send -e -u low -i "" "Normal Transparency"
fi
