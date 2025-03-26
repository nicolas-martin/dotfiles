#!/usr/bin/env bash

sketchybar --add item weather right \
  --set weather \
  update_freq=100 \
  background.padding_left=10 \
  background.padding_right=10 \
  icon.padding_left=10 \
  label.padding_right=10 \
  background.height=26 \
  background.padding_right=5 \
  background.drawing=on \
  script="$PLUGIN_DIR/weather.sh"
