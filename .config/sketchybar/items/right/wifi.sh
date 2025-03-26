#!/usr/bin/env bash

sketchybar --add item wifi right

sketchybar --subscribe wifi wifi_change

sketchybar --set wifi \
  script="~/.config/sketchybar/plugins/wifi.sh" \
  update_freq=2 \
  icon=  \
  icon.drawing=on 
