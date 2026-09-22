EMQX deployed as job "[[ var "job_name" . ]]" (host-networked).

Dashboard: http://<node-ip>:[[ var "dashboard_port" . ]]  (login: admin / the dashboard_password you set)
MQTT TCP:  <node-ip>:[[ var "mqtt_port" . ]]
MQTT WS:   ws://<node-ip>:[[ var "ws_port" . ]]/mqtt
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

The node name is pinned to emqx@127.0.0.1 so data survives restarts. Retained messages,
sessions, and rules live on the [[ var "data_volume" . ]] volume (/opt/emqx/data).

By default any client may connect (anonymous). Enable authentication/ACLs from the dashboard for
anything exposed beyond a trusted network. Pin the job to the node holding the volume with the
constraints variable.
