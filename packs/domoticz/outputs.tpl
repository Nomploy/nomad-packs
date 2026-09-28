Domoticz deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    http://<node-ip>:[[ var "port" . ]]
HTTPS:     https://<node-ip>:[[ var "https_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Domoticz uses host networking so it can reach devices and discovery on your LAN
— pin it (via constraints) to a node on that network. To use USB dongles (Z-Wave,
Zigbee, RFXCOM), add a devices stanza to the task for the relevant /dev path.
The database and config persist in the data_volume.
