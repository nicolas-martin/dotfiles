#!/usr/bin/env bash
# sketchybar --add item title q 
# sketchybar --set title \
#     script="$PLUGIN_DIR/title.sh" 


sketchybar \
  --add item title q \
  --set title \
    script="$PLUGIN_DIR/title.sh" \
    padding_left=2 \
    padding_right=8 \
    background.border_width=0 \
    background.height=24 \
  --subscribe title \
    window_focus \
    front_app_switched \
    space_change \
    title_change

