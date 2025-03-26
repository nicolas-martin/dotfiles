sketchybar \
  --add item yabai_mode left \
  --set yabai_mode \
    padding_left=3 \
    padding_right=10 \
    update_freq=5 \
    script="$PLUGIN_DIR/yabai_mode.sh" \
    click_script="$PLUGIN_DIR/yabai_click.sh" \
  --subscribe yabai_mode \
    mouse.clicked \
    window_focus \
    front_app_switched \
    space_change \
    title_change

