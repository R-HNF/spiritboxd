#!/bin/bash

## Execute at HOME DIRECTORY on the host or the container.

source spiritboxd/.env
echo 'Start building docker image...'

docker build -t spiritboxd:latest \
    --build-arg USERNAME=$USERNAME \
    --build-arg GROUPNAME=$GROUPNAME \
    --build-arg PASSWORD=$PASSWORD \
    --build-arg EMAIL=$EMAIL \
    -f spiritboxd/Dockerfile \
    .

echo 'Finish.'