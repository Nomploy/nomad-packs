pgAdmin deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]  (login [[ var "email" . ]] / <password>)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (saved connections + prefs)

Add a server pointing at the postgres pack: host 127.0.0.1 (same node) or <node-ip>, port
5432. Serves plain HTTP — front with a reverse proxy for TLS, and keep it internal.
