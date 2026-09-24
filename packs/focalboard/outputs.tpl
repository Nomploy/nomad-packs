Focalboard deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/opt/focalboard/data: SQLite DB + files) — back it up

Register an account on first visit, then create boards with kanban / table / gallery / calendar views. The
container listens on 8000; to change the port, edit config.json in the data volume. Serves plain HTTP — front it
with a reverse proxy for TLS.
