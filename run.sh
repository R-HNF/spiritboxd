#!/bin/bash

echo 'Start spiritboxd...'
docker stop spiritboxd || true \
docker rm spiritboxd || true \
&& docker run \
    -v $HOME/workspace/:/home/$(whoami)/workspace/ \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --network host \
    -h spiritboxd \
    --add-host spiritboxd:127.0.0.1 \
    --name spiritboxd \
    --restart always -itd spiritboxd:latest
