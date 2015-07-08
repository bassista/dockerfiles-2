#!/bin/bash

IMAGE_NAME="bibryam/base-jdk"
IMAGE_TAG="7"

# ********************************************
# Build the container image and tag it as latest
# ********************************************
echo "Building the Docker container for $IMAGE_NAME:$IMAGE_TAG"
docker build --rm -t $IMAGE_NAME:$IMAGE_TAG .
[ "0" != $(docker images | grep $IMAGE_NAME  | grep latest | wc -l) ] && ( docker rmi -f $IMAGE_NAME:latest )
docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest
echo "Build done"