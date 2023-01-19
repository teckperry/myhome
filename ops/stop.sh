#!/bin/sh

CONTAINER=$(sudo docker container inspect -f '{{.Id}}' $1)
STATUS=$(sudo docker container inspect -f '{{.State.Status}}' $1)

if [ "$CONTAINER" ]
then
    if [ "$STATUS" = 'running' ]
    then
        echo "Stop $1 container ..."
        sudo docker stop $1
    else
        echo "The container $1 is not running."
    fi
else
    echo "There aren't $1 containers."
fi