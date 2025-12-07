#!/bin/bash

# Path to Waypaper's configuration file
CONFIG_FILE="$HOME/.config/waypaper/config.ini"

# Check if the config file exists
if [ -f "$CONFIG_FILE" ]; then
    # Use grep to find the line with 'wallpaper_path', then cut to get the path
    # The path will be between 'wallpaper_path=' and 'last_changed'
    WALLPAPER_PATH=$(grep "wallpaper_path=" "$CONFIG_FILE" | cut -d'=' -f2 | cut -d';' -f1 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Print the path. Hyprlock will use this as its background.
    echo "$WALLPAPER_PATH"
fi
