WeKan deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

MongoDB is bundled as a prestart sidecar (port [[ var "mongo_port" . ]]). Register
the first account to get started. Set root_url to the public address you serve
WeKan from — it's used in invitation and password-reset emails. Boards live in
MongoDB; uploads/attachments in the data_volume.
