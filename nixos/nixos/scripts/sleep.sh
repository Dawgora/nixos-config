#!/usr/bin/env sh

sleep 1

swayidle -w timeout 300 'lock-if-idle' \
         timeout 600 'niri msg action power-off-monitors' \
         resume 'niri msg action power-on-monitors' &
