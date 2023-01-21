# ############## #
#      MAIN      #
# ############## #
setup:
	# Setup Portainer
	@$(MAKE) setup-container target=portainer
	@$(MAKE) start-container target=portainer
	# Setup Home Assistant
	@$(MAKE) setup-container target=homeassistant
	@$(MAKE) start-container target=homeassistant
	@$(MAKE) config-homeassistant
	# Setup Mosquitto
	@$(MAKE) setup-container target=mosquitto
	@$(MAKE) config-mosquitto-folders
	@$(MAKE) start-container target=mosquitto
	@$(MAKE) config-mosquitto-user
	@$(MAKE) config-mosquitto-config
	# Setup Zigbee2MQTT
	@$(MAKE) setup-container target=zigbee2mqtt
	@$(MAKE) start-container target=zigbee2mqtt
	@$(MAKE) config-zigbee2mqtt
	# Setup InfluxDB
	@$(MAKE) setup-container target=influxdb
	@$(MAKE) start-container target=influxdb
	# Setup Grafana
	@$(MAKE) setup-container target=grafana
	@$(MAKE) start-container target=grafana
	# Restart all Containers
	@$(MAKE) restart

start:
	@$(MAKE) start-container target=portainer
	@$(MAKE) start-container target=homeassistant
	@$(MAKE) start-container target=mosquitto
	@$(MAKE) start-container target=zigbee2mqtt
	@$(MAKE) start-container target=influxdb
	@$(MAKE) start-container target=grafana

restart:
	@$(MAKE) restart-container target=homeassistant
	@$(MAKE) restart-container target=mosquitto
	@$(MAKE) restart-container target=zigbee2mqtt
	@$(MAKE) restart-container target=influxdb
	@$(MAKE) restart-container target=grafana

stop:
	@$(MAKE) stop-container target=homeassistant
	@$(MAKE) stop-container target=mosquitto
	@$(MAKE) stop-container target=zigbee2mqtt
	@$(MAKE) stop-container target=influxdb
	@$(MAKE) stop-container target=grafana

# ############# #
#    HELPERS    #
# ############# #
config-homeassistant:
	@sh ops/config_homeassistant.sh

config-mosquitto-folders:
	@sh ops/config_mosquitto_folders.sh

config-mosquitto-user:
	@sh ops/config_mosquitto_user.sh

config-mosquitto-config:
	@sh ops/config_mosquitto_config.sh

config-zigbee2mqtt:
	@sh ops/config_zigbee2mqtt.sh

setup-container:
	@sh ops/setup.sh $(target)

start-container:
	@sh ops/start.sh $(target)

restart-container:
	@sh ops/restart.sh $(target)

stop-container:
	@sh ops/stop.sh $(target)

clean:
	@$(MAKE) stop
	@sh ops/clean.sh homeassistant
	@sh ops/clean.sh mosquitto
	@sh ops/clean.sh zigbee2mqtt
	@sh ops/clean.sh influxdb
	@sh ops/clean.sh grafana