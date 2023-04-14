#!/bin/bash

# Set container names
STACK_CONTAINER_NAME="stack_f1tenth"
SYSTEM_CONTAINER_NAME="system_f1tenth"

# Build the stack container
echo "Building the stack container..."
docker build -t $STACK_CONTAINER_NAME -f dockerfiles/stack.Dockerfile .

# Build the system container
echo "Building the system container..."
docker build -t $SYSTEM_CONTAINER_NAME -f dockerfiles/system.Dockerfile .

# Run the stack container
echo "Running the stack container..."
docker run -d --name $STACK_CONTAINER_NAME --network host -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix/:/tmp/.X11-unix -v /dev:/dev \
    $STACK_CONTAINER_NAME

# Run the system container
echo "Running the system container..."
docker run -d --name $SYSTEM_CONTAINER_NAME --runtime nvidia --network host -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix/:/tmp/.X11-unix -v /dev:/dev \
    --mount type=volume,dst=/f1tenth_ws,volume-driver=local,volume-opt=type=none,volume-opt=o=bind,volume-opt=device


