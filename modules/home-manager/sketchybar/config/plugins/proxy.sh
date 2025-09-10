#!/bin/bash


is_on=$(scutil --proxy | grep 'ProxyAutoConfigEnable : 1')

if [ -n "$is_on" ]; then
  proxy="󰖂 on!"
else
  proxy="󰖂 off"
fi

sketchybar --set "$NAME" label="$proxy"
