#!/usr/bin/env bash


sketchybar --add event update_window_mode

sketchybar --add item window_mode left \
           --set window_mode script="$PLUGIN_DIR/yabai_mode2.sh" \
                                 updates=on \
                                 icon.drawing=off \
           --subscribe window_mode update_window_mode
