#!/bin/bash
set -e

# Start a VNC server on display :1, no desktop session management needed.
# This will provide an explicit port 5901 for raw VNC, which can help Codespaces port forwarding.

if pgrep -x x11vnc >/dev/null; then
  echo "x11vnc already running"
  exit 0
fi

# Start x11vnc on display :0 for browser access via noVNC or raw VNC.
# Use a fixed port in the container (5900) and allow connections without a password for Codespaces internal forwarding.

x11vnc -display :0 -nopw -forever -shared -rfbport 5900 -bg

echo "x11vnc started on port 5900"
