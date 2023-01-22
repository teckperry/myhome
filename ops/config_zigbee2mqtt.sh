#!/bin/sh

SERIAL_PORT_VAR=$(grep SERIAL_PORT myconfig/envs/zigbee2mqtt.env | xargs) 
SERIAL_PORT="${SERIAL_PORT_VAR#SERIAL_PORT=}"

MOSQUITTO_SERVER_VAR=$(grep MOSQUITTO_SERVER myconfig/envs/zigbee2mqtt.env | xargs) 
MOSQUITTO_SERVER="${MOSQUITTO_SERVER_VAR#MOSQUITTO_SERVER=}"

MOSQUITTO_USER_VAR=$(grep MOSQUITTO_USER myconfig/envs/zigbee2mqtt.env | xargs) 
MOSQUITTO_USER="${MOSQUITTO_USER_VAR#MOSQUITTO_USER=}"

MOSQUITTO_PASSWORD_VAR=$(grep MOSQUITTO_PASSWORD myconfig/envs/zigbee2mqtt.env | xargs) 
MOSQUITTO_PASSWORD="${MOSQUITTO_PASSWORD_VAR#MOSQUITTO_PASSWORD=}"

ZIGBEE2MQTT_PORT_VAR=$(grep ZIGBEE2MQTT_PORT myconfig/envs/zigbee2mqtt.env | xargs) 
ZIGBEE2MQTT_PORT="${ZIGBEE2MQTT_PORT_VAR#ZIGBEE2MQTT_PORT=}"

ZIGBEE2MQTT_URL_VAR=$(grep ZIGBEE2MQTT_URL myconfig/envs/zigbee2mqtt.env | xargs) 
ZIGBEE2MQTT_URL="${ZIGBEE2MQTT_URL_VAR#ZIGBEE2MQTT_URL=}"

ZIGBEE2MQTT_CHANNEL="24"
ZIGBEE2MQTT_CHANNEL_VAR=$(grep ZIGBEE2MQTT_CHANNEL myconfig/envs/zigbee2mqtt.env | xargs) 
ZIGBEE2MQTT_CHANNEL="${ZIGBEE2MQTT_CHANNEL_VAR#ZIGBEE2MQTT_CHANNEL=}"

echo "
# Adapter settings
serial:
  port: ${SERIAL_PORT}

# Home Assistant integration
homeassistant: true

# Zigbee network - do not allow random devices to connect automatically (false value)
permit_join: false

# MQTT (Mosquitto) integration
mqtt:
  base_topic: zigbee2mqtt
  server: ${MOSQUITTO_SERVER}
  user: ${MOSQUITTO_USER}
  password: ${MOSQUITTO_PASSWORD}
  client_id: zigbee

frontend:
  port: ${ZIGBEE2MQTT_PORT}
  url: ${ZIGBEE2MQTT_URL}

advanced:
  pan_id: GENERATE
  network_key: GENERATE
  channel: ${ZIGBEE2MQTT_CHANNEL}

devices: devices.yaml
groups: groups.yaml
" >> myconfig/zigbee2mqtt/zigbee2mqtt-data/app/data/configuration.yaml

sudo cp -rf myconfig/zigbee2mqtt/zigbee2mqtt-data/* zigbee2mqtt/zigbee2mqtt-data