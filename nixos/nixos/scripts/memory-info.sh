#!/usr/bin/env bash
# Memory usage for waybar

# Read from /proc/meminfo (most accurate)
MEM_TOTAL=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
MEM_FREE=$(awk '/MemFree/ {print $2}' /proc/meminfo)
MEM_AVAILABLE=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
MEM_CACHED=$(awk '/^Cached:/ {print $2}' /proc/meminfo)
SWAP_TOTAL=$(awk '/SwapTotal/ {print $2}' /proc/meminfo)
SWAP_FREE=$(awk '/SwapFree/ {print $2}' /proc/meminfo)

# Convert KB to GiB
to_gib() { echo "scale=2; $1 / 1048576" | bc; }

TOTAL_GIB=$(to_gib $MEM_TOTAL)
USED_GIB=$(to_gib $(( MEM_TOTAL - MEM_FREE - MEM_CACHED )))
AVAIL_GIB=$(to_gib $MEM_AVAILABLE)
SWAP_USED_GIB=$(to_gib $(( SWAP_TOTAL - SWAP_FREE )))

# Calculate percentage
if [ $MEM_TOTAL -gt 0 ]; then
  PERCENT=$(( (MEM_TOTAL - MEM_FREE - MEM_CACHED) * 100 / MEM_TOTAL ))
else
  PERCENT=0
fi

# Label and tooltip
LABEL="RAM"
TOOLTIP=$(printf '%s\nTotal: %s GiB\nUsed: %s GiB (%d%%)\nFree: %s GiB\nCached: %s GiB\n\nSwap:\nUsed: %s GiB' \
         "$LABEL" "$TOTAL_GIB" "$USED_GIB" "$PERCENT" \
         "$(to_gib $MEM_FREE)" "$(to_gib $MEM_CACHED)" "$SWAP_USED_GIB")

# Output JSON
jq -nc --arg text "💾 ${PERCENT}%" \
       --arg class "used" \
       --arg tooltip "$TOOLTIP" \
   '{text: $text, class: $class, tooltip: $tooltip}'
