Mealie deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/app/data: SQLite DB + recipe images) — back it up

First run creates the default admin — check the docs for the initial credentials
(changeme@example.com / MyPassword) and change them immediately. Uses SQLite (great for a household
or small team). Set BASE_URL to your real domain, and serve behind a reverse proxy for TLS.
