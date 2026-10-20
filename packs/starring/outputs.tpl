Starring deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Database:  co-located PostgreSQL on port [[ var "db_port" . ]], volume "[[ var "db_data_volume" . ]]" — back it up

Bundled: the Starring app + PostgreSQL 17, with the app gated on the database being
ready (no boot-time crash loop). Set better_auth_url to your real domain and keep
better_auth_secret STABLE. Serves plain HTTP — front it with a reverse proxy for TLS.
With password_auth=true you can create the first user from the UI.
