#!/usr/bin/env bash

# Wallpaper
swww-daemon &
sleep 1

set-backgrounds &

waybar &
sleep 2        # give the watcher a moment to own the D-Bus name

# Tray applets AFTER the watcher exists
nm-applet --indicator &
blueman-applet &
protonvpn-app &
mako &
