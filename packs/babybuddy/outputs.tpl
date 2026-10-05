Baby Buddy deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Baby Buddy stores its config and SQLite database in the babybuddy_config volume. Sign in
with the default account:

  username: admin
  password: admin

Change the password immediately. When serving it on a domain, add that URL to
csrf_trusted_origins (comma-separated) or form submissions will be rejected. The web
server listens on port 8000 inside the container.
