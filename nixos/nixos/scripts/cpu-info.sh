#!/usr/bin/env bash
# CPU usage per-core + temp for waybar

read_cpu() {
  awk '/^cpu[0-9]/ {print $2+$3+$4+$5+$6+$7+$8, $2+$3+$4}' /proc/stat
}
T1=$(read_cpu)
sleep 0.3
T2=$(read_cpu)

# Per-core percentages + average in one awk pass
STATS=$(paste <(echo "$T1") <(echo "$T2") | awk '
  {
    all = $3 - $1; busy = $4 - $2
    pct = (all > 0) ? busy * 100 / all : 0
    printf "CORE %d %.0f\n", NR-1, pct
    sum += pct; n++
  }
  END { printf "AVG %.0f\n", sum / n }')

OVERALL=$(echo "$STATS" | awk '/^AVG/ {print $2}')
CORES_TXT=$(echo "$STATS" | grep '^CORE' | awk '{printf "Core %s: %s%%\n", $2, $3}')

# Temperature: coretemp (Intel) or k10temp/zenpower (AMD)
TEMP_FILE=""
for d in /sys/class/hwmon/hwmon*; do
  case "$(cat "$d/name" 2>/dev/null)" in
    coretemp|k10temp|zenpower) TEMP_FILE="$d/temp1_input"; break ;;
  esac
done

if [ -f "$TEMP_FILE" ]; then
  TEMP_C=$(( $(cat "$TEMP_FILE") / 1000 ))
  TEMP_LINE="Temp: ${TEMP_C}°C"
else
  TEMP_LINE="Temp: n/a"
fi

TOOLTIP=$(printf 'CPU: %s%% overall\n\n%s\n%s' "$OVERALL" "$CORES_TXT" "$TEMP_LINE")

jq -nc --arg text " ${OVERALL}%" \
       --arg class "used" \
       --arg tooltip "$TOOLTIP" \
   '{text: $text, class: $class, tooltip: $tooltip}'
