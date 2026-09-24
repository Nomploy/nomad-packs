Zigbee2MQTT deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Frontend:  http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/app/data: config + network state) — BACK IT UP (re-pairing is painful)

Requires a Zigbee USB coordinator at [[ var "serial_device" . ]] on this node (pin the job there with
constraints) and an MQTT broker at [[ var "mqtt_server" . ]] (deploy the mosquitto pack first). Open the frontend,
enable "permit join" temporarily to pair devices, then point Home Assistant at the same MQTT broker. Front the UI
with a reverse proxy for TLS.
