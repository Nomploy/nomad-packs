RedisInsight deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]  (accept the terms, then add a database)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (saved connections)

Add the redis pack: host 127.0.0.1 (same node) or <node-ip>, port 6379 (+ password if set).
Serves plain HTTP — keep it internal / behind a reverse proxy.
