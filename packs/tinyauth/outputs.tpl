Tinyauth deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Server:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Tinyauth is a forward-auth middleware: point your reverse proxy's forward-auth
at http://<node-ip>:[[ var "port" . ]]/api/auth/traefik (or /nginx) to gate any
app behind a login. Set app_url to your public URL, change secret (exactly 32
chars) and replace the default user (generate a hash with `tinyauth user create`).
