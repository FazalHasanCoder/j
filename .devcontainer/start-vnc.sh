#!/bin/bash
set -e

export DISPLAY=:0

start_process() {
  local cmd="$1"
  if ! pgrep -f "$cmd" >/dev/null 2>&1; then
    bash -lc "$cmd"
  fi
}

if ! pgrep -f "Xvfb :0" >/dev/null 2>&1; then
  Xvfb :0 -screen 0 1920x1080x24 &
  sleep 2
  echo "Started Xvfb :0"
fi

if ! pgrep -f "fluxbox" >/dev/null 2>&1; then
  fluxbox &
  sleep 2
  echo "Started fluxbox"
fi

if ! pgrep -f "x11vnc.*-rfbport 5900" >/dev/null 2>&1; then
  x11vnc -display :0 -nopw -forever -shared -rfbport 5900 -bg
  sleep 2
  echo "Started x11vnc on port 5900"
fi

if ! pgrep -f "websockify --web" >/dev/null 2>&1; then
  websockify --web /usr/share/novnc/ 6080 localhost:5900 &
  sleep 2
  echo "Started noVNC web server on port 6080"
fi

echo "Desktop environment ready. Access noVNC on port 6080 or VNC on port 5900."
