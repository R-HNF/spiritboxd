#!/bin/bash

echo 'Start spiritboxd...'
docker stop spiritboxd || true \
docker rm spiritboxd || true \
&& docker run \
    -h spiritboxd \
    --add-host spiritboxd:127.0.0.1 \
    --network host \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $HOME/workspace/:/home/$(whoami)/workspace/ \
    --name spiritboxd \
    --restart always -itd spiritboxd:latest
