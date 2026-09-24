WeTTY deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]/
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Opens a browser terminal that SSHes to [[ var "ssh_user" . ]]@[[ var "ssh_host" . ]]:[[ var "ssh_port" . ]]. You
authenticate with your normal SSH credentials/keys. Stateless — no volumes. This exposes shell access over the
web, so keep it OFF the public internet or behind an authenticating reverse proxy with TLS, and prefer SSH keys.
