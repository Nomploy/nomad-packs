Home Assistant deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Open the URL and complete the onboarding wizard (create your account and home). Host networking is
used so device discovery / mDNS works. Config, database, and integrations live on the
[[ var "data_volume" . ]] volume (/config) — back it up and pin the job to that node with the
constraints variable.

Notes: hardware integrations that need a USB dongle (Zigbee/Z-Wave) or Bluetooth require device
passthrough / extra privileges not configured here; add them per your setup. Home Assistant binds
port 8123 by default — to change it, set http.server_port in configuration.yaml after first boot and
update the port variable to match.
