ESPHome deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Dashboard: http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Create device YAML configs in the dashboard, compile firmware, and flash over the network (OTA)
or via USB (initial flash usually needs USB on a machine with the device attached). Host networking
is used so the dashboard can discover devices via mDNS. Configs and the build cache live on the
[[ var "data_volume" . ]] volume (/config) — pin the job to that node with the constraints variable.
Pairs with the home-assistant and mosquitto packs.
