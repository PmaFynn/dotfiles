#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/images/wallpaper"

# 1. Pick a random file (Absolute path is key for hyprpaper)
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# 2. Run both commands separately but fast
# We send errors to /dev/null so "invalid request" doesn't show up
hyprctl hyprpaper preload "$WALLPAPER" > /dev/null 2>&1
hyprctl hyprpaper wallpaper "DP-1,$WALLPAPER" > /dev/null 2>&1

# 3. Clean up the OLD wallpapers in the background so it doesn't slow you down
(hyprctl hyprpaper unload all > /dev/null 2>&1) &
