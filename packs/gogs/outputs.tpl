Gogs deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    http://<node-ip>:[[ var "http_port" . ]]   (complete the one-time install form on first visit)
Git SSH:   ssh://git@<node-ip>:[[ var "ssh_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

On first visit Gogs shows an install page — the SQLite defaults work out of the
box; set the application URL to your public address and create the admin account.
SSH is on [[ var "ssh_port" . ]] to avoid the host's own sshd. Repos, the SQLite
database and config persist in the data_volume at /data.
