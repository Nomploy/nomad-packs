SiYuan deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Workspace: Docker volume "[[ var "workspace_volume" . ]]" (/siyuan/workspace: notes + assets) — back it up

Open the URL and unlock with your access auth code. Notes are stored as plain Markdown + JSON in the
workspace volume. Serves plain HTTP — front it with a reverse proxy for TLS. The desktop/mobile SiYuan apps
can also sync to this server. Anyone with the access code can read/write everything, so keep it strong.
