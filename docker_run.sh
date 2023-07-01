#!/bin/bash
# Docker run script to use until docker compose works on the Jetson

# Set the name and tag for the Docker image
REPO_NAME=$(basename "$(git rev-parse --show-toplevel)")
IMAGE_NAME="$REPO_NAME"
IMAGE_TAG="latest"

# Build the Docker image
docker run \
    --gpus all \
    --runtime=nvidia \
    -it \
    --network=host \
    --privileged \
    -v /xavier_ssd/docker_testing/$REPO_NAME/:/ws/src/$REPO_NAME/ \
    -v /xavier_ssd/docker_testing/$REPO_NAME/fs_msgs/:/ws/src/fs_msgs/ \
    -v /xavier_ssd/docker_testing/$REPO_NAME/fs_common/:/ws/src/fs_common \
    -n $REPO_NAME
    $IMAGE_NAME:$IMAGE_TAG