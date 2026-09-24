Ghostfolio deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Database:  co-located PostgreSQL on port [[ var "db_port" . ]], volume "[[ var "db_data_volume" . ]]" — back it up
Cache:     co-located Redis on port [[ var "redis_port" . ]]

Bundled: the Ghostfolio app + PostgreSQL + Redis. Migrations run automatically on boot. Open the app,
create your account, and add accounts/holdings (stocks, ETFs, crypto, cash). Keep ACCESS_TOKEN_SALT and
JWT_SECRET_KEY stable and secret. Serves plain HTTP — front it with a reverse proxy for TLS.
