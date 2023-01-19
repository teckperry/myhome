#!/bin/sh

echo "\n-------------------------\n"

echo "Create $1 container ..."
cd $1
sudo docker-compose -f $1.yaml up -d

echo "\n-------------------------\n"