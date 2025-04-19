#!/bin/bash

echo "Starting MeshSense in headless mode..."
echo "Using node address: $ADDRESS"
if [ -n "$ACCESS_KEY" ]; then
  echo "ACCESS_KEY is set"
fi

# Run MeshSense in headless mode
dbus-run-session xvfb-run /app/meshsense.AppImage --headless \
  --disable-gpu --in-process-gpu --disable-software-rasterizer