#!/usr/bin/env bash
# Usage: disk-info.sh [/] [/mnt/old_ssd] [/mnt/hdd] [/mnt/windows_game_dir]

MOUNTPOINT="${1:-/}"

if ! mountpoint -q "$MOUNTPOINT" 2>/dev/null; then
  echo '{"text": "--", "class": "offline"}'
  exit 0
fi

INFO=$(df -BG "$MOUNTPOINT" 2>/dev/null | tail -1)
TOTAL=$(echo "$INFO" | awk '{print $2}' | tr -d 'G')
USED=$(echo "$INFO" | awk '{print $3}' | tr -d 'G')
AVAIL=$(echo "$INFO" | awk '{print $4}' | tr -d 'G')
PERCENT=$(echo "$INFO" | awk '{print $5}' | tr -d '%')

# Determine label based on mountpoint
case "$MOUNTPOINT" in
  "/") LABEL="ROOT" ;;
  "/mnt/old_ssd") LABEL="SSD" ;;
  "/mnt/hdd") LABEL="HDD" ;;
  "/mnt/windows_game_dir") LABEL="WIN" ;;
  *) LABEL="$MOUNTPOINT" ;;
esac

# Output JSON for waybar
jq -nc --arg text "$LABEL:$PERCENT%" \
       --arg class "mounted" \
       --arg tt "$(printf '%s\n%s: %s / %s GiB (%s%%)\nAvailable: %s GiB\n\nMount: %s' \
                "$LABEL" "$LABEL" "$USED" "$TOTAL" "$PERCENT" "$AVAIL" "$MOUNTPOINT")" \
   '{text: $text, class: $class, tooltip: $tt}'
