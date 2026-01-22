#! /usr/bin/env bash

set -euo pipefail

folders=(bat btop dunst fastfetch gtk-3.0 gtk-4.0 hypr kitty Kvantum micro nwg-look rofi starship waybar wlogout xonsh xsettingsd yazi)

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dest="$script_dir/config"

mkdir -p "$dest"

for f in "${folders[@]}"; do
	src="$HOME/.config/$f"
	if [ -e "$src" ]; then
		echo "Copying $f from $src to $dest/$f"
		mkdir -p "$dest/$f"
		rsync -a --delete "$src/" "$dest/$f/"
	else
		echo "Skipping $f: not found at $src" >&2
	fi
done

echo "Done. Copied available folders to $dest"

