Audiobookshelf deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Create the admin account on first visit, then add a library pointing at /audiobooks.

Volumes (Docker named):
  - [[ var "config_volume" . ]]   -> /config      (settings + database)
  - [[ var "metadata_volume" . ]] -> /metadata    (covers, cache)
  - [[ var "library_volume" . ]]  -> /audiobooks  (your media — fill it)

Pin the job to the node holding the volumes with the constraints variable.
