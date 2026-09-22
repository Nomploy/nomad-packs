PhotoPrism deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Login:     [[ var "admin_user" . ]] / (the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Volumes (Docker named):
  - [[ var "storage_volume" . ]]   -> /photoprism/storage    (SQLite DB, cache, thumbnails — BACK UP)
  - [[ var "originals_volume" . ]] -> /photoprism/originals  (your photos & videos)

Add photos to the originals volume, then run Library -> Index to import them. Uses SQLite
(fine for personal libraries; MariaDB is recommended for very large ones). Indexing and face
recognition are memory-hungry — 4GB+ RAM recommended. Pin the job to the node holding the
volumes with the constraints variable.
