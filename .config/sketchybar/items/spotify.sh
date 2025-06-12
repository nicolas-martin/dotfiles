#!/usr/bin/env bash

COLOR="$ORANGE"

echo "[sketchybarrc] CONFIG_DIR=$CONFIG_DIR" >&2
echo "[sketchybarrc] PLUGIN_DIR=$PLUGIN_DIR" >&2
echo "[sketchybarrc] ITEM_DIR=$ITEM_DIR" >&2
echo "[spotify plugin] handling media_change event with INFO:" >&2
echo "$INFO" | jq . >&2
sketchybar --add item spotify q \
  --set spotify \
    script="$PLUGIN_DIR/spotify.sh" \
    update_freq=2 \
    scroll_texts=on \
    icon=󰎆 \
    icon.color="$COLOR" \
    background.height=26 \
    background.corner_radius="$CORNER_RADIUS" \
    background.border_width="$BORDER_WIDTH" \
    background.padding_right=-5 \
    background.drawing=on \
    label.padding_right=10 \
    label.max_chars=30 \
    # associated_display=active \
    updates=on \
		--subscribe spotify media_change
