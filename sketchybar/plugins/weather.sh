#!/bin/sh

# ---- Get location with retry ----
MAX_RETRIES=5
SLEEP_BETWEEN=2
LAT=""
LON=""

for i in $(seq 1 $MAX_RETRIES); do
  LOC=$(/opt/homebrew/bin/CoreLocationCLI -once 2>/dev/null)
  LAT=$(echo "$LOC" | awk '{print $1}')
  LON=$(echo "$LOC" | awk '{print $2}')
  if [ -n "$LAT" ] && [ -n "$LON" ]; then
    break
  fi
  sleep $SLEEP_BETWEEN
done

# Fallback if still no location
if [ -z "$LAT" ] || [ -z "$LON" ]; then
  LAT="39.7392"
  LON="-104.9903"
fi

# Use Celsius
URL="https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m,weather_code,precipitation&timezone=auto&temperature_unit=celsius"

DATA=$(curl -s "$URL")

# Quick guard if DATA is empty or invalid
if [ -z "$DATA" ] || ! echo "$DATA" | jq -e . >/dev/null 2>&1; then
  sketchybar --set "$NAME" icon="" label="N/A"
  exit 0
fi

FORECAST=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&hourly=precipitation&forecast_hours=2&timezone=auto&precipitation_unit=mm")

if [ -z "$FORECAST" ] || ! echo "$FORECAST" | jq -e . >/dev/null 2>&1; then
  RAIN_NEXT_2HRS=0
else
  RAIN_NEXT_2HRS=$(echo "$FORECAST" | jq '[.hourly.precipitation[0:2][]] | add')
  # Round rain to 2 decimal places
  RAIN_NEXT_2HRS=$(printf "%.2f" "$RAIN_NEXT_2HRS")
fi

TEMP=$(echo "$DATA" | jq -r '.current.temperature_2m')
CODE=$(echo "$DATA" | jq -r '.current.weather_code')

if [ -z "$TEMP" ] || [ "$TEMP" = "null" ]; then
  sketchybar --set "$NAME" icon="" label="N/A"
  exit 0
fi

# Map WMO code to icon 
case $CODE in
  0) ICON="" ;;
  1|2|3) ICON="" ;;
  45|48) ICON="" ;;
  51|53|55) ICON="" ;;
  56|57) ICON="?" ;;
  61|63|65) ICON="" ;;
  66|67) ICON="?" ;;
  71|73|75) ICON="󰖘" ;;
  77) ICON="?" ;;
  80|81|82) ICON="" ;;
  85|86) ICON="?" ;;
  95) ICON="󰖓" ;;
  96|99) ICON="?" ;;
  *) ICON="" ;;
esac

TEMP_LABEL="$(printf "%.0f°C" "$TEMP")"

if [ "$(echo "$RAIN_NEXT_2HRS > 0" | bc -l)" -eq 1 ]; then
  LABEL="$TEMP_LABEL, ${RAIN_NEXT_2HRS} mm"
  COLOR="0xFF89b4fa"
  sketchybar --set "$NAME" icon="$ICON" label="$LABEL" icon.color=$COLOR label.color=$COLOR
else
  LABEL="$TEMP_LABEL"
  sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
fi
