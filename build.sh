#!/bin/bash

echo 'Start building docker image...'
docker build \
    --build-arg USERNAME=user \ 
    --build-arg GROUPNAME=group \
    --build-arg PASSWORD=password \
    -t spiritboxd:latest \
    -f spiritboxd/Dockerfile .
echo 'Finish.'