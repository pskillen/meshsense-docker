# Meshsense Docker Setup

This repository contains Docker configuration files to run Meshsense in headless mode on a Linux server.

## Prerequisites

- Docker and Docker Compose installed on your system

## Quick Start

1. Update the environment variables in `docker-compose.yml` to match your setup
2. Run the container:

```bash
docker-compose up -d
```

## Configuration

### Environment Variables

The following environment variables can be configured in the `docker-compose.yml` file:

| Variable   | Description                                                            | Default     |
|------------|------------------------------------------------------------------------|-------------|
| ADDRESS    | Address of the physical radio node hardware that Meshsense connects to | 10.0.1.20   |
| ACCESS_KEY | Optional secret key for admin privileges in the web UI                 | myAccessKey |

### Docker Compose

The included `docker-compose.yml` file provides a ready-to-use configuration:

```yaml
services:
  meshsense:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: meshsense
    environment:
      - ADDRESS=192.168.178.89  # Address of Meshtastic Node (physical radio hardware)
      # - ACCESS_KEY=myAccessKey  # Optional secret key for admin privileges in web UI
    restart: unless-stopped
    ports:
      - "5920:5920"  # Web interface port
```

## Manual Build and Run

If you prefer to build and run the container manually:

1. Build the Docker image:

```bash
docker build -t meshsense .
```

2. Run the container:

```bash
docker run -d \
  --name meshsense \
  -e ADDRESS=192.168.178.89 \
  -e ACCESS_KEY=myAccessKey \
  -p 5920:5920 \
  meshsense
```

## Logs and Troubleshooting

To view the logs from the container:

```bash
docker logs meshsense
```

To enter the container for debugging:

```bash
docker exec -it meshsense /bin/bash
```

## Notes

- The container runs Meshsense in headless mode with the necessary flags to disable GPU and software rasterization
- All required dependencies for running Electron in headless mode are included in the Docker image
- The Meshsense AppImage is automatically downloaded during the Docker image build process
- The container uses a custom entrypoint script (`docker-entrypoint.sh`) to start Meshsense with the appropriate
  configuration
