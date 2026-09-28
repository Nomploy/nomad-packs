Kestra deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

PostgreSQL is bundled as a prestart sidecar (port [[ var "db_port" . ]]) and
holds Kestra's repository and queue; flow storage lives in the storage_volume.
The Docker socket is bind-mounted so the Docker task runner can execute
containerized tasks (set docker_sock="" to disable). Change db_password before
deploying anywhere real.
