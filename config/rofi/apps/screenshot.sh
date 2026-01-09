#!/usr/bin/env bash
# Rofi screenshot menu with grimblast/grim + slurp fallbacks
set -euo pipefail

THEME="$HOME/.config/rofi/apps/theme.rasi"
OUTDIR="$HOME/Images/Screenshots"

timestamp() { date +"%Y-%m-%d_%H%M%S"; }
rofi_cmd() { rofi -dmenu -p "Screenshot" -theme "$THEME"; }

options="📷\n🪟\n✂️\n⏳5\n⏳10\n📋"
chosen=$(echo -e "$options" | rofi_cmd)

case "$chosen" in
    📷)
        command grimblast -w 1 save screen && notify-send -u low "Screenshot saved"
        ;;
    🪟)
        command grimblast -w 1 save active && notify-send -u low "Screenshot saved"
        ;;
    ✂️)
        command grimblast -w 1 save area && notify-send -u low "Screenshot saved"
        ;;
    "⏳5")
        command grimblast -w 5 save screen && notify-send -u low "Screenshot saved"
        ;;
    "⏳10")
        command grimblast -w 10 save screen && notify-send -u low "Screenshot saved"
        ;;
    📋)
        command grimblast copy screen && notify-send -u low "Screenshot copied"
        ;;
    *)
        exit 0
        ;;
esac

exit 0
