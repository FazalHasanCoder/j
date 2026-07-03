#!/bin/bash
set -e

export DISPLAY=:99

if pgrep -f "Xvfb :99" >/dev/null 2>&1; then
  echo "Xvfb already running"
else
  Xvfb :99 -screen 0 1920x1080x24 &
  sleep 2
  echo "Started Xvfb :99"
fi

if pgrep -f "fluxbox" >/dev/null 2>&1; then
  echo "fluxbox already running"
else
  fluxbox &
  sleep 2
  echo "Started fluxbox"
fi

if pgrep -f "x11vnc.*-rfbport 5900" >/dev/null 2>&1; then
  echo "x11vnc already running"
else
  x11vnc -display :99 -localhost -nopw -forever -shared -rfbport 5900 -bg
  sleep 2
  echo "Started x11vnc on localhost:5900"
fi

if pgrep -f "websockify --web" >/dev/null 2>&1; then
  echo "websockify already running"
else
  if [ ! -d "/opt/novnc" ]; then
    echo "Downloading noVNC..."
    mkdir -p /opt/novnc
    wget -q https://github.com/novnc/noVNC/archive/refs/tags/v1.6.0.tar.gz -O /tmp/novnc.tar.gz
    tar -xzf /tmp/novnc.tar.gz -C /opt/novnc --strip-components=1
    rm /tmp/novnc.tar.gz
  fi
  websockify --web /opt/novnc --bind=0.0.0.0 6080 localhost:5900 &
  sleep 2
  echo "Started noVNC web server on port 6080"
fi

echo "Desktop environment ready. Access noVNC at port 6080."
