#!/usr/bin/env bash

# Wallpaper
awww init &

awww img -o HDMI-A-2 ~/.local/share/backgrounds/side-screens.jpg \
  --resize fill --transition-type any --transition-duration 1.5

awww img -o DP-3 ~/.local/share/backgrounds/middle-screen-2.jpg \
  --resize fill --transition-type any --transition-duration 1.5

awww img -o DP-4 ~/.local/share/backgrounds/side-screens.jpg \
  --resize fill --transition-type any --transition-duration 1.5

waybar &
sleep 2        # give the watcher a moment to own the D-Bus name

# Tray applets AFTER the watcher exists
nm-applet --indicator &
blueman-applet &
protonvpn-app &
mako &
