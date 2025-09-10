#!/usr/bin/env fish

networksetup -getautoproxyurl 'Wi-Fi' | grep 'Enabled: No' &> /dev/null

if [ $status -eq 0 ]
  sketchybar --set "proxy" label="󰖂: on!"
  enable_proxy
else
  disable_proxy
  sketchybar --set "proxy" label="󰖂: off"
end



