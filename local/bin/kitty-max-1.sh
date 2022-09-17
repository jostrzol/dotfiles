#!/bin/sh

target_win_id=$("$HOME/.local/bin/win_id.sh" kitty)
active_win_id=$(printf "0x%08x\n" "$(xdotool getactivewindow)")

echo "$target_win_id $active_win_id"

if [ -z "$target_win_id" ]; then
  kitty
elif [ "$target_win_id" = "$active_win_id" ]; then
  xdotool windowminimize "$target_win_id"
else
  wmctrl -ia "$target_win_id"
fi

