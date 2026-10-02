ZITADEL deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Console:   http://<node-ip>:[[ var "port" . ]]/ui/console
Login:     [[ var "admin_username" . ]]@zitadel.[[ var "external_domain" . ]]  /  (the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

PostgreSQL is bundled as a prestart sidecar (port [[ var "db_port" . ]]). Set
external_domain to the host users actually reach ZITADEL at (and external_secure=true
behind an HTTPS proxy) — it's baked into issued tokens, so changing it later is
disruptive. Change masterkey (exactly 32 chars, keep it stable), db_password and
admin_password before deploying anywhere real.
