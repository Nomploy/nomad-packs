Forgejo deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    http://<node-ip>:[[ var "http_port" . ]]
Git SSH:   ssh://git@<node-ip>:[[ var "ssh_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/data: SQLite DB + repositories) — back it up

Open the web UI and complete the first-run setup; the first registered user becomes the admin. Set ROOT_URL
to your real domain so clone URLs and links are correct. Uses SQLite (great for small teams). Serves plain
HTTP — front it with a reverse proxy for TLS. Forgejo Actions (CI) can be enabled with a runner.
