#!/usr/bin/env bash
# Waybar media status pill - single-line JSON output (waybar requirement)
# "chromium" prefix-matches any chromium.instanceNNNN, so this survives restarts

PLAYER="chromium"

STATUS=$(playerctl status -p "$PLAYER" 2>/dev/null)

if [ "$STATUS" = "Playing" ] || [ "$STATUS" = "Paused" ]; then
  ARTIST=$(playerctl metadata -p "$PLAYER" artist 2>/dev/null)
  TITLE=$(playerctl metadata -p "$PLAYER" title 2>/dev/null)

  if [ "$STATUS" = "Playing" ]; then
    ICON=""
    CLASS="connected"
  else
    ICON=""
    CLASS="disconnected"
  fi

  jq -nc --arg text "$ICON $TITLE" --arg class "$CLASS" --arg tt "$ARTIST — $TITLE" \
    '{text: (.text | if length > 30 then .[:27] + "…" else . end),
      class: $class, alt: $class, tooltip: $tt}'
else
  jq -nc '{text: "Nothing playing", class: "inactive", tooltip: "Media: Idle"}'
fi
