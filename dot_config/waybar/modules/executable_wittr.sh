#!/bin/sh

LOCATION="$1"

# Map WEATHER_SYMBOL values to Symbols Nerd Font Mono
symbol_map() {
  case "$1" in
  "✨") echo "\uf12b" ;;        # Unknown
  "☁️" | "☁") echo "\uf0c2" ;; # Cloudy / VeryCloudy
  "🌫") echo "\uf014" ;;        # Fog
  "🌧") echo "\uf740" ;;        # HeavyRain / HeavyShowers / LightSleet / LightSleetShowers
  "❄️" | "❄") echo "\uf2dc" ;; # HeavySnow / HeavySnowShowers / LightSnow / LightSnowShowers
  "🌦") echo "\uf741" ;;        # LightRain / LightShowers
  "🌨") echo "\uf2dc" ;;        # LightSnow / LightSnowShowers
  "⛅️" | "⛅") echo "\uf0c4" ;; # PartlyCloudy
  "☀️" | "☀") echo "\uf185" ;; # Sunny
  "🌩") echo "\uf76c" ;;        # ThunderyHeavyRain
  "⛈") echo "\uf76c" ;;        # ThunderyShowers / ThunderySnowShowers
  *) echo "\uf12b" ;;          # fallback Unknown
  esac
}

# Get current temperature
text=$(curl -s "https://wttr.in/$LOCATION?format=1")
if [ $? -eq 0 ]; then
  text=$(echo "$text" | awk '{print $2}' | sed 's/^+//; s/°C//') # strip + and °C

  # Get full JSON forecast
  forecast=$(curl -s "https://wttr.in/$LOCATION?format=j1")
  if [ $? -eq 0 ]; then
    # Extract temperatures for the day
    morning=$(echo "$forecast" | jq -r '.weather[0].hourly[] | select(.time=="900") | .tempC' | sed 's/^+//')
    noon=$(echo "$forecast" | jq -r '.weather[0].hourly[] | select(.time=="1200") | .tempC' | sed 's/^+//')
    afternoon=$(echo "$forecast" | jq -r '.weather[0].hourly[] | select(.time=="1500") | .tempC' | sed 's/^+//')
    evening=$(echo "$forecast" | jq -r '.weather[0].hourly[] | select(.time=="1800") | .tempC' | sed 's/^+//')
    night=$(echo "$forecast" | jq -r '.weather[0].hourly[] | select(.time=="2100") | .tempC' | sed 's/^+//')

    # Format tooltip with emojis
    tooltip="☀️ Morning: ${morning}°C\n🌤 Noon: ${noon}°C\n⛅ Afternoon: ${afternoon}°C\n🌇 Evening: ${evening}°C\n🌙 Night: ${night}°C"

    # Output JSON for Waybar
    echo "{\"text\":\"$text°C\", \"tooltip\":\"$tooltip\"}"
    exit
  fi
fi

# Fallback if all retries fail
echo "{\"text\":\"error\", \"tooltip\":\"error\"}"
