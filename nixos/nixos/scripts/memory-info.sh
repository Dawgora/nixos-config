#!/usr/bin/env bash
# Memory usage for waybar - reads /proc/meminfo

MEM_TOTAL=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
MEM_FREE=$(awk '/MemFree/ {print $2}' /proc/meminfo)
MEM_AVAILABLE=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
MEM_CACHED=$(awk '/^Cached:/ {print $2}' /proc/meminfo)
SWAP_TOTAL=$(awk '/SwapTotal/ {print $2}' /proc/meminfo)
SWAP_FREE=$(awk '/SwapFree/ {print $2}' /proc/meminfo)

# KB -> GiB via awk (bc not needed)
to_gib() { awk -v kb="$1" 'BEGIN { printf "%.1f", kb / 1048576 }'; }
to_mib() { awk -v kb="$1" 'BEGIN { printf "%.0f", kb / 1024 }'; }

TOTAL_GIB=$(to_gib $MEM_TOTAL)
USED_KB=$(( MEM_TOTAL - MEM_AVAILABLE ))
USED_GIB=$(to_gib $USED_KB)
AVAIL_GIB=$(to_gib $MEM_AVAILABLE)
CACHED_GIB=$(to_gib $MEM_CACHED)
SWAP_USED_MIB=$(to_mib $(( SWAP_TOTAL - SWAP_FREE )))

# Percentage of actually-consumed memory
if [ $MEM_TOTAL -gt 0 ]; then
  PERCENT=$(( USED_KB * 100 / MEM_TOTAL ))
else
  PERCENT=0
fi

TOOLTIP=$(printf 'RAM: %s GiB / %s GiB (%d%%)\nAvailable: %s GiB\nCached: %s GiB\n\nSwap used: %s MiB' \
          "$USED_GIB" "$TOTAL_GIB" "$PERCENT" "$AVAIL_GIB" "$CACHED_GIB" "$SWAP_USED_MIB")

jq -nc --arg text " ${PERCENT}%" \
       --arg class "used" \
       --arg tooltip "$TOOLTIP" \
   '{text: $text, class: $class, tooltip: $tooltip}'
