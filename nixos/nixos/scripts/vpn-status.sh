#!/usr/bin/env bash
# Waybar VPN status pill - single-line JSON output (waybar requirement)

ACTIVE=$(nmcli -t -f NAME con show --active 2>/dev/null | grep -i "proton\|vpn")

if [ -n "$ACTIVE" ]; then
  NAME=$(echo "$ACTIVE" | head -n1 | cut -d: -f1)
  jq -nc --arg name "$NAME" \
    '{text: "On", class: "connected", alt: "connected", tooltip: ("ProtonVPN: Active\nConnection: " + $name)}'
else
  jq -nc \
    '{text: "Off", class: "disconnected", alt: "disconnected", tooltip: "ProtonVPN: Inactive\nClick to open the app"}'
fi
