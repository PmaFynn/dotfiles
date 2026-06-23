#!/usr/bin/env bash

# Ask for the English word
WORD=$(rofi -dmenu -p "Synonyms for:" -config "/home/fynn/.config/rofi/config_small.rasi")

# Exit if no word typed
[ -z "$WORD" ] && exit

# Lookup using sdcv, JSON output, Moby Thesaurus
sdcv -n --json --use-dict "Moby Thesaurus II" "$WORD" \
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
| rofi -dmenu -p "Synonyms:"
