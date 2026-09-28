Portainer deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI (HTTPS): https://<node-ip>:[[ var "port" . ]]   (create the admin account within a few minutes of first start)
Web UI (HTTP):  http://<node-ip>:[[ var "http_port" . ]]
Discovery:      Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Portainer manages the Docker socket of the node it runs on, so pin it (via
constraints) to that node. On first start, open the UI promptly and set the
admin password (Portainer locks initial setup after a timeout for security).
Data persists in the data_volume at /data.
