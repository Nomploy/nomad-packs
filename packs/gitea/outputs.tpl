Gitea deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    [[ if ne (var "root_url" .) "" ]][[ var "root_url" . ]][[ else ]]http://<node-ip>:[[ var "http_port" . ]][[ end ]]
Git SSH:   port [[ var "ssh_port" . ]]  (ssh://git@[[ if ne (var "ssh_domain" .) "" ]][[ var "ssh_domain" . ]][[ else ]]<node-ip>[[ end ]]:[[ var "ssh_port" . ]]/…)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on the HTTP port
Data:      Docker volume "[[ var "data_volume" . ]]" (repos + SQLite DB + config) — back it up

First visit shows the install page (pre-filled with the bundled SQLite DB) — click
"Install Gitea", then register. The FIRST registered user becomes the site admin.
Container/package registry is built in: docker login <node-ip>:[[ var "http_port" . ]]
