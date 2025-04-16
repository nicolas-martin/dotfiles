#!/usr/bin/env bash
echo "[spotify plugin] script invoked with args: $@" >&2

COLOR="$ORANGE"

sketchybar --add item spotify q \
  --set spotify \
  scroll_texts=on \
  icon=󰎆 \
  icon.color="$COLOR" \
  icon.padding_left=10 \
  background.height=26 \
  background.corner_radius="$CORNER_RADIUS" \
  background.border_width="$BORDER_WIDTH" \
  background.padding_right=-5 \
  background.drawing=on \
  label.padding_right=10 \
  label.max_chars=20 \
  associated_display=active \
  updates=on \
  script="$PLUGIN_DIR/spotify.sh" \
  --subscribe spotify media_change

sketchybar --set spotify drawing=on

