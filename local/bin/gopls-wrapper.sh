#!/usr/bin/env sh

SOCKET=/tmp/gopls-daemon-socket
LOCKDIR=/tmp/gopls-daemon-socket.lock

if ! lsof -t "$SOCKET" >/dev/null 2>&1; then
  # no server started
  if mkdir -- "$LOCKDIR" >/dev/null 2>&1; then
    # no server started and lock acquired
    rm "$SOCKET" >/dev/null 2>&1
    trap 'trap - SIGTERM; rmdir "$LOCKDIR"; rm "$SOCKET"; kill -- -$$' INT TERM EXIT
    gopls -listen="unix;$SOCKET" >/dev/null 2>&1 &
  fi
  # no server started, but other wrapper will take care of it
fi

while ! lsof -t "$SOCKET" >/dev/null 2>&1; do sleep 0.01; done

# server running
gopls -remote="unix;$SOCKET" "$@"
