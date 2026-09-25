#!/usr/bin/env sh

sleep 1

swayidle -w timeout 300 'lock-if-idle lock' \
         timeout 600 'lock-if-idle poweroff' \
         resume 'niri msg action power-on-monitors' &
