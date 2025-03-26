#!/usr/bin/env bash

##### Adding Left Items #####
# We add some regular items to the left side of the bar, where
# only the properties deviating from the current defaults need to be set

sketchybar --add item chevron left \
           --set chevron icon= label.drawing=off \
           --add item front_app left \
           --set front_app icon.drawing=off script="$PLUGIN_DIR/front_app.sh" \
           --subscribe front_app front_app_switched
