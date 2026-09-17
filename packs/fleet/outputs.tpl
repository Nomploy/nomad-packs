Fleet deployed as job "[[ var "job_name" . ]]" (all-in-one: Fleet + MySQL + Redis, host-networked).

Open:       http://<node-ip>:[[ var "port" . ]]  (plain HTTP — front with TLS via a reverse proxy)
First run:  the UI walks you through creating the initial admin user.
Discovery:  Nomad service "[[ var "job_name" . ]]" (provider=nomad) on port [[ var "port" . ]]
Ports:      Fleet [[ var "port" . ]] · MySQL [[ var "mysql_port" . ]] · Redis [[ var "redis_port" . ]] (all on the host)
State:      Docker volume "[[ var "mysql_data_volume" . ]]" (MySQL — back this up) + "[[ var "redis_data_volume" . ]]" (Redis AOF)

Note: DB migrations run automatically on start (fleet prepare db). Enroll hosts by
generating an installer/enroll secret from the Fleet UI once it is up.
