#!/usr/bin/env bash

# Get the container ID by matching the image name prefix
CONTAINER=$(docker container ls --format '{{.ID}} {{.Image}} {{.Names}}' | grep -i "ros2-devcontainer" | awk '{print $1}')

# Execute the entrypoint script inside the container
docker container exec -it "$CONTAINER"  /entrypoint.sh tmux
