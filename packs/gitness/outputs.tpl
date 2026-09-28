Harness Open Source (Gitness) deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    http://<node-ip>:[[ var "port" . ]]   (create the admin account on first visit)
Git SSH:   ssh://git@<node-ip>:[[ var "ssh_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

The Docker socket is bind-mounted so built-in CI/CD pipelines can run containers
on the node (set docker_sock="" to disable). The database and all repositories
persist in the data_volume at /data.
