#!/bin/sh

echo "Create dir $1/$1-data"
sudo mkdir $1/$1-data

echo "Set permissions $1/$1-data"
sudo chmod 777 -R $1/$1-data