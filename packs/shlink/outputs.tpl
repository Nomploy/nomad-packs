Shlink deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API/redirects: http://<node-ip>:[[ var "port" . ]]
Discovery:     Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Database:      co-located PostgreSQL on port [[ var "db_port" . ]], volume "[[ var "db_data_volume" . ]]" — back it up

Set DEFAULT_DOMAIN to your real short-link domain and IS_HTTPS_ENABLED=true behind a TLS proxy — the
domain is stored on every short URL. Use INITIAL_API_KEY with the CLI or the separate shlink-web-client
to create and manage links. Short links are served from this app, so point your domain at it.
