# About

This is yet another Home Assistant configuration.

Welcome and enjoy!


# Requirements

- docker
- docker-compose


# Commands

- make
- rm
- cp
- echo
- mv
- mkdir
- chmod
- grep
- docker container inspect
- docker exec
- docker restart
- docker stop
- docker-compose up


# Containers list

- Home Assistant
- Portainer
- InfluxDB
- Mosquitto
- Grafana


# Table of Contents

1. [Config Environment variables](#1-config-environment-variables)
2. [Setup containers](#2-setup-containers)
3. [Setup Home Assistant](#3-setup-home-assistant)
    1. [Mosquitto Configuration](#1-mosquitto-configuration)
    2. [InfluxDB Configuration](#2-influxdb-configuration)
    3. [Grafana Configuration](#3-grafana-configuration)
4. [Config Home Assistant Secrets](#4-config-home-assistant-secrets)
    1. [Portainer Secrets](#1-portainer-secrets)
    2. [Grafana Secrets](#2-grafana-secrets)
    3. [InfluxDB Secrets](#3-influxdb-secrets)
5. [Config and Restart](#5-config-and-restart)
6. [Standard Network Map](#6-standard-network-map)


# How To

## 1. Config Environment variables

#### 1. Mosquitto

1. Create `mosquitto.env` into `myconfig/envs`
2. Add these variables:
```
USER={mosquitto_user}
PASSWORD={mosquitto_password}
```

#### 2. Zigbee2MQTT

1. Create `zigbee2mqtt.env` into `myconfig/envs`
2. Add these variables:
```
SERIAL_PORT={usb_serial}
MOSQUITTO_SERVER=mqtt://{mosquitto_ip}:{mosquitto_port}
MOSQUITTO_USER={mosquitto_user}
MOSQUITTO_PASSWORD={mosquitto_password}
ZIGBEE2MQTT_PORT={zigbee2mqtt_frontend_port}
ZIGBEE2MQTT_URL={zigbee2mqtt_url}:{zigbee2mqtt_frontend_port}
ZIGBEE2MQTT_CHANNEL={zigbee2mqtt_channel}
```

##### How to retrieve SERIAL_PORT

1. Exec `ls -l /dev/serial/by-id`
2. The string before `->` is your Zigbee Adapter Serial, the string after the symbol is your Serial Port.
3. Change the Zigbee Adapter Serial and the Serial Port into `zigbee2mqtt.yaml` and `homeassistant.yaml`


## 2. Setup containers

1. Open the terminal
2. Change directory to the root folder of this project
3. Exec `make setup` command


## 3. Setup Home Assistant

#### 1. Mosquitto Configuration

1) Go to `Home Assistant / Settings / Integrations`
2) Search `MQTT`
3) Insert *broker* `172.22.0.5`
4) Insert *user* (`{mosquitto_user}`) and *password* (`{mosquitto_password}`) from the `mosquitto.env` file (**1.1.2**)


#### 2. InfluxDB Configuration

1. Go to InfluxDB (`172.22.0.3:8086`)
2. Create a new account:
    - Insert *username* and *password*
    - Insert your InfluxDB *organization* (`{influxdb_org}`)
    - Insert your InfluxDB *bucket* (`{influxdb_bucket}`)
3. Go to `Load data` (the second sidebar button)
4. Click on `API TOKENS` tab
5. Generate a new Api Token
6. Copy the generated Api Token (`{influxdb_token}`)


#### 3. Grafana Configuration

1. Go to Grafana (`172.22.0.4:3000`)
2. Login using `admin` (user and password)
3. Change password
4. Go to `Settings / Data Sources`
5. Search `InfluxDB`
6. Change Query Language from `InfluxQL` to `Flux`
7. Deselect `Basic auth` configuration
8. Insert these params:
    - Insert URL `http://influxdb:8086`
    - Insert your InfluxDB *organization* (`{influxdb_org}`) (**3.2.2**)
    - Insert your InfluxDB *token* (`{influxdb_token}`) (**3.2.6**)
    - Insert your InfluxDB *bucket* (`{influxdb_bucket}`) (**3.2.2**)
9. Click `Save and test`


## 4. Config Home Assistant Secrets

#### 1. Portainer Secrets

1) If not exists create a file `secrets.yaml` into `myconfig/homeassistant/homeassistant-data/config`
2) Add these variables:
```
portainer_url: {portainer_url}
```

#### 2. Grafana Secrets

1) If not exists create a file `secrets.yaml` into `myconfig/homeassistant/homeassistant-data/config`
2) Add these variables:
```
grafana_url: {grafana_url}
```

#### 3. InfluxDB Secrets

1) If not exists create a file `secrets.yaml` into `myconfig/homeassistant/homeassistant-data/config`
2) Add these variables:
```
influxdb_url: {influxdb_url}
influxdb_host: {influxdb_host}
influxdb_port: {influxdb_port}
influxdb_token: {influxdb_token}
influxdb_org: {influxdb_org}
influxdb_bucket: {influxdb_bucket}
```

#### 4. Zigbee2MQTT Secrets

1) If not exists create a file `secrets.yaml` into `myconfig/homeassistant/homeassistant-data/config`
2) Add these variables:
```
zigbee2mqtt_url: {zigbee2mqtt_url}:{zigbee2mqtt_frontend_port}
```


## 5. Config and Restart

1) Open the terminal
2) Change directory to the root folder of this project
3) Exec `make config-homeassistant` command
4) Exec `make restart` command


## 6. Standard Network Map

| Name | Port | Front-Network IP | Back-Network IP |
| - | - | - | - |
| Gateway | - | 172.21.0.1 | 172.22.0.1 |
| Portainer | 9000 | - | - |
| Home Assistant | 8123 | 172.21.0.2 | 172.22.0.2 | 
| InfluxDB | 8086 | 172.21.0.3 | 172.22.0.3 |
| Grafana | 3000 | 172.21.0.4 | 172.22.0.4 |
| Mosquitto | 1883, 9001 | 172.21.0.5 | 172.22.0.5 |