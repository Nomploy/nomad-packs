DocuSeal deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/data: SQLite DB + uploaded documents) — back it up

On first run, open the UI to create the admin account. Uses SQLite by default (great for small teams);
to use PostgreSQL instead, add DATABASE_URL to the docuseal task. Configure SMTP (SMTP_ADDRESS, etc.) to
email signing requests. Serves plain HTTP — front it with a reverse proxy for TLS.
