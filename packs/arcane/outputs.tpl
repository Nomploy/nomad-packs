Arcane deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Arcane manages the host's Docker via the mounted socket ([[ var "docker_socket" . ]]) and
stores its own state in SQLite inside the arcane_data volume. Create the first admin
account in the UI.

CHANGE encryption_key (exactly 32 characters) and jwt_secret before deploying anywhere
real, and keep them stable. Because it mounts the Docker socket it effectively has root on
the node, so keep it behind your VPN or an authenticating reverse proxy and restrict who
can reach it.
