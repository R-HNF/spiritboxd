#!/bin/bash

## Execute on the host.

source spiritboxd/.env

docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME || true

docker run \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --network host \
    --name $CONTAINER_NAME \
    -h $CONTAINER_NAME \
    --add-host $CONTAINER_NAME:127.0.0.1 \
    -v $WORKSPACE:/home/$USERNAME/workspace/ \
    --restart always -itd spiritboxd:latest
