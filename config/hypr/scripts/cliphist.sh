#!/usr/bin/env bash

cliphist list | rofi -dmenu -theme ~/.config/rofi/themes/cliphist.rasinc | cliphist decode | wl-copy
