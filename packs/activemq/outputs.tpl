ActiveMQ Artemis deployed as job "[[ var "job_name" . ]]" (host-networked).

Console:   http://<node-ip>:[[ var "port" . ]]/console   (login: [[ var "admin_user" . ]] / the admin_password you set)
Protocols: core/OpenWire [[ var "core_port" . ]] · AMQP [[ var "amqp_port" . ]] · MQTT [[ var "mqtt_port" . ]] · STOMP [[ var "stomp_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Change admin_password before deploying anywhere real. The broker instance (config,
data journal and logs) persists in the data_volume.
