Paperless-ngx deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Login:     [[ var "admin_user" . ]] / (the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Tasks: redis (broker, prestart sidecar) + paperless (app, SQLite).

Volumes (Docker named):
  - [[ var "data_volume" . ]]    -> /usr/src/paperless/data     (SQLite DB + search index)
  - [[ var "media_volume" . ]]   -> /usr/src/paperless/media    (archived documents — BACK UP)
  - [[ var "consume_volume" . ]] -> /usr/src/paperless/consume  (drop files here to import)

First start runs migrations and creates the superuser (slower). Drop documents into the consume
volume (or upload via the UI) and Paperless will OCR and file them. Set PAPERLESS_URL (the url
variable) if you expose it on a domain. Pin the job to the node holding the volumes.
