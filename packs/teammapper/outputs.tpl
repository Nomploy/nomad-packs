TeamMapper deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Database:  co-located PostgreSQL on port [[ var "db_port" . ]], volume "[[ var "db_data_volume" . ]]" — back it up

Create a mind map and share the link to collaborate in real time. Maps not accessed within
DELETE_AFTER_DAYS ([[ var "delete_after_days" . ]]) days are pruned automatically — set it to 0 to keep
them forever. Serves plain HTTP — front it with a reverse proxy for TLS.
