Khoj deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Bundled: PostgreSQL + pgvector (prestart sidecar, port [[ var "db_port" . ]]). On first
start Khoj downloads embedding models into the khoj_models volume (this takes a few
minutes and some disk/RAM) and runs migrations automatically.

CHANGE db_password, django_secret_key and admin_password before deploying anywhere real,
and keep django_secret_key stable. Configure chat models (local Ollama or a cloud API
key) in the admin settings after first login.

NOTE: this pack runs Khoj in --anonymous-mode (no login wall), matching the upstream
docker-compose — anyone who can reach the port has access. Keep it behind your VPN or a
reverse proxy with authentication. Web search (searxng_url) and the code sandbox
(terrarium_url) are optional: deploy those services separately and set the URLs.
