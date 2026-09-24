Homarr deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/appdata: DB, boards, config) — back it up

Create the admin account on first visit, then build your board with widgets and app integrations. Keep
SECRET_ENCRYPTION_KEY stable — it encrypts stored credentials, and changing it makes them unreadable. Serves
plain HTTP — front it with a reverse proxy for TLS.
