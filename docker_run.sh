#!/bin/bash
# Docker run script to use until docker compose works on the Jetson

# Set the name and tag for the Docker image
REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
IMAGE_NAME="$REPO_NAME"
IMAGE_TAG="latest"

# Build the Docker image
docker run \
    -it \
    --network=host \
    --privileged \
    -v /xavier_ssd/docker_testing/$REPO_NAME/:/ws/src/$REPO_NAME/ \
    --name $REPO_NAME \
    $IMAGE_NAME:$IMAGE_TAG

        # -v /xavier_ssd/docker_testing/$REPO_NAME/dragandbot_common/:/ws/src/dragandbot_common/ \