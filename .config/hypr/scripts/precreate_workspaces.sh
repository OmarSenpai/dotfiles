#!/usr/bin/env bash
sleep 1  # wait for Hyprland to initialize fully

# assign workspaces explicitly to eDP-1
for i in {1..10}; do
    hyprctl dispatch workspace $i@eDP-1
done
