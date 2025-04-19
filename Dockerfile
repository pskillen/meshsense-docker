FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
  libx11-xcb1 libxcb-dri3-0 libasound2 \
  libxcomposite1 libxcursor1 libxdamage1 libxi6 \
  libxtst6 libnss3 libxrandr2 libatk1.0-0 \
  libatk-bridge2.0-0 libgtk-3-0 libdrm2 \
  wget ca-certificates libgbm1 xvfb x11-utils \
  dbus \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Add non-root user
RUN useradd -ms /bin/bash meshsense

# Download, extract and move AppImage to /meshsense (must be done as root)
WORKDIR /tmp
RUN wget https://affirmatech.com/download/meshsense/meshsense-x86_64.AppImage -O meshsense.AppImage \
  && chmod +x meshsense.AppImage \
  && ./meshsense.AppImage --appimage-extract \
  && mv squashfs-root /meshsense \
  && chown -R meshsense:meshsense /meshsense

# Copy and set up entrypoint script
COPY docker-entrypoint.sh /meshsense/
RUN chmod +x /meshsense/docker-entrypoint.sh

# Set environment variables with defaults
# Address of the physical radio node hardware that Meshsense connects to
ENV ADDRESS=192.168.178.89
# Optional secret key for admin privileges in the web UI
ENV ACCESS_KEY=""
# Port the Meshsense app runs on (typically static at 5920)
ENV PORT=5920

# Disable Electron sandbox (safe in containers)
ENV ELECTRON_DISABLE_SANDBOX=true
ENV APPDIR=/meshsense

# Switch to non-root user
USER meshsense
WORKDIR /meshsense

# Use entrypoint script
ENTRYPOINT ["/meshsense/docker-entrypoint.sh"]
