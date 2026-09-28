WUD deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]   (login: [[ var "admin_user" . ]] / the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

WUD watches the Docker socket of the node it runs on, so pin it (via constraints)
to the node whose containers you want to monitor. Change admin_password before
deploying anywhere real. Configure notification/auto-update triggers via the
additional WUD_TRIGGER_* env vars (see the docs).
