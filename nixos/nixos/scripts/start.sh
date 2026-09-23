#!/usr/bin/env bash

# Wallpaper
awww init &

waybar &
sleep 2        # give the watcher a moment to own the D-Bus name

# Tray applets AFTER the watcher exists
nm-applet --indicator &
blueman-applet &
protonvpn-app &

# Notification daemon
mako &
