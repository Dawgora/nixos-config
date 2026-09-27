#!/usr/bin/env bash
# Waybar media pill - shows song name + progress, or launches Tidal if idle

PLAYER="chromium"

STATUS=$(playerctl status -p "$PLAYER" 2>/dev/null)

if [ "$STATUS" = "Playing" ] || [ "$STATUS" = "Paused" ]; then
  # Get artist, title, and timing info
  ARTIST=$(playerctl metadata -p "$PLAYER" artist 2>/dev/null | head -c 50)
  TITLE=$(playerctl metadata -p "$PLAYER" title 2>/dev/null | head -c 50)
  POSITION=$(playerctl position -p "$PLAYER" 2>/dev/null)
  DURATION=$(playerctl metadata -p "$PLAYER" mpris:length 2>/dev/null)

  # Convert microseconds to seconds (mpris:length is in microseconds)
  if [ -n "$DURATION" ]; then
    DURATION_SEC=$(( DURATION / 1000000 ))
  else
    DURATION_SEC=0
  fi

  # Format time as MM:SS
  fmt_time() {
    printf '%d:%02d' $(( ${1%.*} / 60 )) $(( ${1%.*} % 60 ))
  }

  if [ -n "$POSITION" ]; then
    POS_FMT=$(fmt_time "$POSITION")
    DUR_FMT=$(fmt_time "$DURATION_SEC")
    TIME_PROGRESS=" (${POS_FMT}/${DUR_FMT})"
  fi

  # Truncate title to fit bar width (max ~25 chars for space + time)
  DISPLAY_TITLE="${TITLE:0:25}"
  if [ ${#TITLE} -gt 25 ]; then
    DISPLAY_TITLE="${DISPLAY_TITLE}..."
  fi

  FULL_TEXT="${TITLE}${TIME_PROGRESS}"

  if [ "$STATUS" = "Playing" ]; then
    ICON=""
    CLASS="connected"
  else
    ICON=""
    CLASS="paused"
  fi

  # Tooltip shows full artist/title, bar shows title + time
  jq -nc --arg text "$FULL_TEXT" --arg class "$CLASS" \
       --arg tooltip "Artist: $ARTIST
Title: $TITLE
Position: $POS_FMT / $DUR_FMT" \
    '{text: $text, class: $class, alt: $class, tooltip: $tooltip}'
else
  # Nothing playing — show message, click to launch Tidal
  jq -nc '{text: "Nothing playing", class: "inactive", alt: "inactive",
          tooltip: "Click to open Tidal"}'
fi
