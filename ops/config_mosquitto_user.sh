#!/bin/sh

CONTAINER=$(sudo docker container inspect -f '{{.Id}}' "mosquitto")

USER_VAR=$(grep USER myconfig/envs/mosquitto.env | xargs) 
MOSQUITTO_USER="${USER_VAR#USER=}"
PASSWORD_VAR=$(grep PASSWORD myconfig/envs/mosquitto.env | xargs)
MOSQUITTO_PASSWORD="${PASSWORD_VAR#PASSWORD=}"

sudo docker exec -it $CONTAINER mosquitto_passwd -b -c /mosquitto/config/password.txt $MOSQUITTO_USER $MOSQUITTO_PASSWORD