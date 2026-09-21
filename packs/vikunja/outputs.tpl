Vikunja deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      [[ if ne (var "public_url" .) "" ]][[ var "public_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]  (register the first account)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (SQLite DB + uploads at /db/files) — back it up

Uses the bundled SQLite DB. When fronting with a domain/proxy, set public_url (with a
trailing slash) so the frontend can reach the API, and a stable service_secret.
