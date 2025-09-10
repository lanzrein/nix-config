#!/bin/bash

wifi_name=$(networksetup -listpreferredwirelessnetworks en0 | grep -v '^Preferred networks on' | head -1 | xargs)
en0_status=$(ifconfig en0 | grep 'status:' | awk '{print $2}')
if [ "$en0_status" = "active" ]; then
  wifi_label=" <$wifi_name>"
else
  wifi_label="󰤯 <off>"
fi


sketchybar --set "$NAME" label="$wifi_label"
