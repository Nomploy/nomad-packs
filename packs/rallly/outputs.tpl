Rallly deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Database:  co-located PostgreSQL on port [[ var "db_port" . ]], volume "[[ var "db_data_volume" . ]]" — back it up

The app runs its database migrations automatically on first boot. Set NEXT_PUBLIC_BASE_URL
(base_url) to your real domain so poll links and emails are correct, and configure SMTP env vars
to send invitations. Serves plain HTTP — front it with a reverse proxy for TLS.
