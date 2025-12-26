#!/usr/bin/env bash

# Ask for the word
WORD=$(rofi -dmenu -p "Define:" -config "/home/fynn/.config/rofi/config_small.rasi") 

# Exit if no word typed
[ -z "$WORD" ] && exit

# Lookup using sdcv, JSON output, only GCIDE
sdcv -n --json --use-dict dictd_www.dict.org_gcide "$WORD" \
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
| rofi -dmenu -p "Definition:"
