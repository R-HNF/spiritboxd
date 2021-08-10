#!/bin/bash

echo 'Start building docker image...'
docker build \
    -f spiritboxd/Dockerfile \
    -t spiritboxd:latest \
    --build-arg USERNAME=user \
    --build-arg GROUPNAME=group \
    --build-arg PASSWORD=password \
    .
echo 'Finish.'