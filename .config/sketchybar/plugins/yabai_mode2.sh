#!/bin/bash

# Query focused window and space
window=$(yabai -m query --windows --window)
space=$(yabai -m query --spaces --space)

# Fallback if window query fails
if [[ "$window" == "null" || -z "$window" ]]; then
  sketchybar --set "$NAME" label="—"
  exit 0
fi

is_floating=$(echo "$window" | jq -r '.["is-floating"]')
space_type=$(echo "$space" | jq -r '.type')

if [[ "$is_floating" == "true" ]]; then
  mode="float"
elif [[ "$space_type" == "stack" ]]; then
  mode="stack"
else
  mode="bsp"
fi

sketchybar --set "$NAME" label="$mode"

