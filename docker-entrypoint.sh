#!/bin/bash

echo "Starting MeshSense in headless mode..."
echo "Using node address: $ADDRESS"
if [ -n "$ACCESS_KEY" ]; then
  echo "ACCESS_KEY is set"
fi

# Run extracted MeshSense in headless mode
dbus-run-session xvfb-run --auto-servernum --server-args='-screen 0 1024x768x24' \
  /meshsense/AppRun --headless --disable-gpu --in-process-gpu --disable-software-rasterizer
