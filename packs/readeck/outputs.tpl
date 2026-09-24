Readeck deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/readeck: SQLite DB + saved articles) — back it up

Create the admin account on first run, then save links via the web UI, the bookmarklet, or the browser
extension — Readeck stores a clean, readable copy (with images and highlights). Serves plain HTTP — front it
with a reverse proxy for TLS.
