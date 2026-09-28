Ackee deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Login:     [[ var "admin_username" . ]] / (the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

MongoDB is bundled as a prestart sidecar (port [[ var "mongo_port" . ]]). Change
admin_password before deploying anywhere real. Add a domain in the UI, then embed
the tiny tracking snippet on your site to start collecting privacy-friendly stats.
