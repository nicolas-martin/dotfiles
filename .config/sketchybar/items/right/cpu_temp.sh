#!/usr/bin/env bash

sketchybar --add item cputemp right

sketchybar --set cputemp \
  update_freq=2 \
  icon=󰏈 \
  script="~/.config/sketchybar/plugins/cpu_temp.sh"
