#!/bin/sh

if [ $# -eq 0 ]; then
  echo "usage: $(basename "$0") WIN_NAME_EXPR" >&2
  exit 1
fi

get_win_id() {
  wmctrl -lp | while read -r id _ pid _; do
    command="$()"
    if ps -o comm= --pid "$pid" | grep -q "$@"; then
      echo "$id"
      return
    fi
  done
}

win_id=$(get_win_id "$@")
if [ -z "$win_id" ]; then
  exit 2
fi

wmctrl -ia "$win_id"
