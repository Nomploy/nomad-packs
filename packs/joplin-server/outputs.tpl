Joplin Server deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Database:  co-located PostgreSQL on port [[ var "db_port" . ]], volume "[[ var "db_data_volume" . ]]" — back it up

Log in to the admin panel with the default admin@localhost / admin and CHANGE the password immediately.
Set APP_BASE_URL (base_url) to your real domain — the Joplin desktop/mobile apps sync against it (choose
the "Joplin Server" sync target and enter that URL + your credentials). Serves plain HTTP — front it with
a reverse proxy for TLS.
