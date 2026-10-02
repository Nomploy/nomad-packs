VerneMQ deployed as job "[[ var "job_name" . ]]" (host-networked).

MQTT:      mqtt://<node-ip>:[[ var "mqtt_port" . ]]
Status:    http://<node-ip>:[[ var "http_port" . ]]/status   (health: /health, metrics: /metrics)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Anonymous access is "[[ var "allow_anonymous" . ]]" — fine for a trusted network,
but for anything exposed set allow_anonymous=off and configure authentication
(password file, or an auth plugin). Message store and metadata persist in the
data_volume.
