Semaphore UI deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volumes "[[ var "data_volume" . ]]" (/var/lib/semaphore, BoltDB) + "[[ var "config_volume" . ]]" — back them up

Log in with SEMAPHORE_ADMIN / SEMAPHORE_ADMIN_PASSWORD, then add a key store, repositories, inventory,
and task templates for Ansible / Terraform / OpenTofu / bash. Keep SEMAPHORE_ACCESS_KEY_ENCRYPTION
stable — it encrypts stored secrets, and changing it makes them unreadable. Serves plain HTTP — front it
with a reverse proxy for TLS.
