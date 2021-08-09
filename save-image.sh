#!/bin/bash

echo 'Saving docker image...'
docker save spiritboxd:latest > $HOME/spiritboxd.tar
ls -lh $HOME/spiritboxd.tar
echo 'Finish.'