#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/images/wallpaper/"

# Get the current wallpaper filenames
CURRENT_WALL=$(hyprctl hyprpaper listloaded | awk '{print $2}')  # get only paths

# Pick a random wallpaper that is not currently loaded
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper reload "DP-3,$WALLPAPER"

