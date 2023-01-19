#!/bin/sh

sudo echo "
persistence true
persistence_location /mosquitto/data/

log_dest stdout
log_dest file /mosquitto/log/mosquitto.log
log_type warning
log_timestamp true
connection_messages true

listener 1883

## Authentication ##
password_file /mosquitto/config/password.txt
" > mosquitto.conf
sudo mv -f mosquitto.conf mosquitto/mosquitto-data/mosquitto/config