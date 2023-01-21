# About

This is yet another Home Assistant configuration.
Welcome and enjoy!

---

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


---
# Table of Contents
- [How To](#how-to)
    1. [Config Environment variables](#1-config-environment-variables)
    2. [Setup containers](#2-setup-containers)
    3. [Setup Home Assistant](#3-setup-home-assistant)
        a. [Mosquitto Configuration](#a-mosquitto-configuration)
        b. [InfluxDB Configuration](#b-influxdb-configuration)
        c. [Grafana Configuration](#c-grafana-configuration)
    4. [Config Home Assistant Secrets](#4-config-home-assistant-secrets)
        a. [Portainer](#a-portainer)
        b. [Grafana](#b-grafana)
        c. [InfluxDB](#c-influxdb)
    5. [Config and Restart](#5-config-and-restart)
- [Standard Network Map](#6-standard-network-map)
---
# How To
## 1. Config Environment variables
### Mosquitto
1. Create `mosquitto.env` into `myconfig/envs`
2. Add these variables:
```
USER={mosquitto_user}
PASSWORD={mosquitto_password}
```

## 2. Setup containers
1. Open the terminal
2. Change directory to the root folder of this project
3. Exec `make setup` command

## 3. Setup Home Assistant
### a. Mosquitto Configuration
1) Go to `Home Assistant / Settings / Integrations`
2) Search `MQTT`
3) Insert *broker* `172.22.0.5`
4) Insert *user* (`{mosquitto_user}`) and *password* (`{mosquitto_password}`) from the `mosquitto.env` file (**1.2**)

### b. InfluxDB Configuration
1. Go to InfluxDB (`172.22.0.3:8086`)
2. Create a new account using:
3. Insert your InfluxDB *organization* (`{influxdb_org}`)
4. Insert your InfluxDB *bucket* (`{influxdb_bucket}`)
5. Go to `Load data` (the second sidebar button)
6. Click on `API TOKENS` tab
7. Generate a new Api Token
8. Copy the generated Api Token (`{influxdb_token}`)

### c. Grafana Configuration
1. Go to Grafana (`172.22.0.4:3000`)
2. Login using `admin` (user and password)
3. Change password
4. Go to `Settings / Data Sources`
5. Search `InfluxDB`
6. Change Query Language from `InfluxQL` to `Flux`
7. Deselect `Basic auth` configuration
8. Insert these params:
    - URL `http://influxdb:8086`
    - Organization `{influxdb_org}`
    - Token `{influxdb_token}`
    - Bucket `{influxdb_bucket}`
9. Click `Save and test`

## 4. Config Home Assistant Secrets
### a. Portainer
1) If not exists create a file `secrets.yaml` into `myconfig/homeassistant/homeassistant-data/config`
2) Add these variables:
```
portainer_url: {portainer_url}
```

### b. Grafana
1) If not exists create a file `secrets.yaml` into `myconfig/homeassistant/homeassistant-data/config`
2) Add these variables:
```
grafana_url: {grafana_url}
```

### c. InfluxDB
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

### 5. Config and Restart
1) Open the terminal
2) Change directory to the root folder of this project
3) Exec `make config-homeassistant` command
4) Exec `make restart` command

---

### Standard Network Map
| Name | Port | Front-Network IP | Back-Network IP |
| - | - | - | - |
| Gateway | - | 172.21.0.1 | 172.22.0.1 |
| Portainer | 9000 | - | - |
| Home Assistant | 8123 | 172.21.0.2 | 172.22.0.2 | 
| InfluxDB | 8086 | 172.21.0.3 | 172.22.0.3 |
| Grafana | 3000 | 172.21.0.4 | 172.22.0.4 |
| Mosquitto | 1883, 9001 | 172.21.0.5 | 172.22.0.5 |