#!/bin/bash

# Root of your password store
root="$HOME/.password-store"

# Flatten the tree, strip the root prefix and .gpg extension, ignoring .git directories
flat_list=$(find "$root" -type d -name ".git" -prune -o -type f -print | sed "s|^$root/||; s|\.gpg$||")


# Use wofi to pick an entry
choice=$(echo "$flat_list" | wofi -d -i)

# If something was selected, show the password and copy it
if [ -n "$choice" ]; then
    pass show "$choice" | head -n 1 | wl-copy
fi
