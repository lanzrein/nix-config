#!/usr/bin/env bash

export CONFIG_DIR=/Users/jlanzrein/.config/sketchybar
source "$CONFIG_DIR/colors.sh"

sketchybar --add item apple.logo left \
  --set apple.logo icon="" \
    label.drawing=off \
    click_script="sketchybar -m --set \$NAME popup.drawing=toggle" \
    popup.background.border_width=2 \
    popup.background.corner_radius=3 \
    popup.background.border_color=0xff9dd274 \
    popup.background.color=0xff000000 \
    popup.background.drawing=on \
  --default background.padding_left=5 \
    background.padding_right=5 \
    icon.padding_right=5 \
 --add item apple.preferences popup.apple.logo \
    --set apple.preferences icon="" \
    label="Settings" \
    click_script="open -a 'System Preferences'; sketchybar -m --set apple.logo popup.drawing=off" \
--add item apple.lock popup.apple.logo \
  --set apple.lock icon="" \
  label="Lock Screen" \
  click_script="pmset displaysleepnow; sketchybar -m --set apple.logo popup.drawing=off"
  background.padding_left=5 \
  background.padding_right=5 \
  icon.padding_right=5