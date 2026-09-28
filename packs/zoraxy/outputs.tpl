Zoraxy deployed as job "[[ var "job_name" . ]]" (host-networked).

Management UI: http://<node-ip>:[[ var "port" . ]]   (create the admin account on first visit)
Discovery:     Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Zoraxy is a reverse proxy: from the UI you define proxy hosts, and Zoraxy binds
the incoming ports (typically 80/443) on the node to serve them. Host networking
makes those ports available — pin the job (via constraints) to the node that
should terminate that traffic, and make sure those ports are free there.
Configuration and certificates persist in the config_volume.
