#!/bin/bash
WALLPAPER=$(find /home/omar/MyCode/Dotfiles/Wallpapers -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" -o -iname "*.gif"\) | shuf -n 1)
pkill swaybg
swaybg -o eDP-1 -i "$WALLPAPER" -m center &
