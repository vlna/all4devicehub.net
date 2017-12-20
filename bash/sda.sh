#!/bin/bash

PROJECTID=<project number>
APIKEYS=<api keys>
DEVICEUUID=<device uuid>

TIMESTAMP=$(date +"%s")

FREEKB=$(df /dev/sda | tail -n1 | awk '{print $4}')
FREEGB=$(echo "scale=2; $FREEKB/1024/1024" | bc)

TEMPERATURE=$(sudo hddtemp /dev/sda -numeric)

curl -H "X-ApiKey: $APIKEYS" -H "Content-Type: application/json" \
     -i "https://api.devicehub.net/v2/project/$PROJECTID/device/$DEVICEUUID/sensor/sda_free_gb/data" \
     -d "{\"value\":$FREEGB,\"timestamp\":$TIMESTAMP}"

curl -H "X-ApiKey: $APIKEYS" -H "Content-Type: application/json" \
     -i "https://api.devicehub.net/v2/project/$PROJECTID/device/$DEVICEUUID/sensor/sda_temperature/data" \
     -d "{\"value\":$TEMPERATURE,\"timestamp\":$TIMESTAMP}"
