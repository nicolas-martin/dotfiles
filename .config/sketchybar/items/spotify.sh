#!/usr/bin/env bash

sketchybar --add item spotify q \
	--set spotify \
	scroll_texts=on \
	icon=󰎆 \
	background.height=26 \
	background.padding_right=-5 \
	background.drawing=on \
	label.max_chars=20 \
	associated_display=active \
	updates=on \
	script="$PLUGIN_DIR/spotify.sh" \
	--subscribe spotify media_change
