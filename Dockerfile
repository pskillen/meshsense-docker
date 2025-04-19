FROM debian:bullseye-slim

# Install required dependencies
RUN apt-get update && apt-get install -y \
    libatk-bridge2.0-0 \
    libcups2 \
    libgdk-pixbuf-2.0-0 \
    libgtk-3-0 \
    libgbm1 \
    xvfb \
    dbus \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Download MeshSense AppImage
RUN wget -O meshsense.AppImage https://affirmatech.com/download/meshsense/meshsense-x86_64.AppImage

# Make the AppImage executable
RUN chmod +x /app/meshsense.AppImage

# Set environment variables with defaults
ENV ADDRESS=127.0.0.1
ENV ACCESS_KEY=""
ENV PORT=5920

# Copy entrypoint script
COPY docker-entrypoint.sh /app/
RUN chmod +x /app/docker-entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/app/docker-entrypoint.sh"]
