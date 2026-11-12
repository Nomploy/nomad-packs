osctrl is deployed as job "[[ var "job_name" . ]]".

Admin UI (React):     http://<node-ip>:[[ var "frontend_port" . ]]
osquery TLS endpoint: http://<node-ip>:[[ var "tls_port" . ]]   (agents enroll/report here)
API:                  http://<node-ip>:[[ var "api_port" . ]]   (proxied by the UI at /api)

Discovery services (Nomad provider):
  [[ var "job_name" . ]]       -> admin UI  (port [[ var "frontend_port" . ]])
  [[ var "job_name" . ]]-tls   -> osquery   (port [[ var "tls_port" . ]])

Log in with the auto-created admin:
  user:     [[ var "admin_user" . ]]
  password: [[ var "admin_password" . ]]      (CHANGE the default!)
  environment: [[ var "env_name" . ]]

Put TLS in front of BOTH the admin UI and the TLS endpoint with your reverse
proxy (Traefik). osquery requires HTTPS to the TLS endpoint — route your
"[[ var "osquery_host" . ]]" domain to the [[ var "job_name" . ]]-tls service.

State: PostgreSQL lives on the named volume "[[ var "db_data_volume" . ]]"
(back it up). Redis is an ephemeral cache. Single-node (count = 1).
