Kener deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Admin:     http://<node-ip>:[[ var "port" . ]]/manage/signin  (create the admin account on first run)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Redis is bundled as a prestart sidecar (port [[ var "redis_port" . ]]) for the
scheduler and caching. Set `origin` to your public URL and change `secret_key`
before deploying anywhere real, otherwise sign-in CSRF checks will fail.
