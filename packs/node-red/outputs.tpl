Node-RED deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Editor:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (flows, credentials, nodes) — back it up

No auth by default — keep it internal or enable adminAuth in settings.js. Wire it to the
mosquitto pack (MQTT), influxdb (storage), etc.
