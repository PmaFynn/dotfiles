#!/usr/bin/env bash

# Ask for the German word
WORD=$(rofi -dmenu -p "Translate (DE->EN):" -config "/home/fynn/.config/rofi/config_small.rasi")

# Exit if no word typed
[ -z "$WORD" ] && exit

# Lookup using sdcv, JSON output, German-English dictionary
sdcv -n --json --use-dict "German - English" "$WORD" \
| jq -r '
  .[] |
  "━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" +
  (.definition
    | gsub("\\r"; "")
    | gsub("\\n{2,}"; "\n\n")
  ) +
  "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
' \
| fold -s -w 80 \
| rofi -dmenu -p "Translation:"
