Dufs deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
WebDAV:    same URL (mount it in your file manager)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Files:     Docker volume "[[ var "data_volume" . ]]" (/data) — the served directory

By default the directory is served READ-ONLY to anyone who can reach the port. Set allow_all=true to
permit uploads/deletes, and set an `auth` rule (e.g. "user:pass@/:rw") to require a login. Serves plain
HTTP — front it with a reverse proxy for TLS, or keep it on an internal network.
