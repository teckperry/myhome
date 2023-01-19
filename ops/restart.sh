#!/bin/sh

echo "\n-------------------------\n"
echo "Handling $1\n"

CONTAINER=$(sudo docker container inspect -f '{{.Id}}' "$1")

if [ "$CONTAINER" ]
then
    echo "Restarting $1 container ..."
    sudo docker restart $CONTAINER
else
    echo "Create $1 container ..."
    cd $1
    sudo docker-compose -f $1.yaml up -d
fi

echo "\n-------------------------\n"