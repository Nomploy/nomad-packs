Komga deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
OPDS:      http://<node-ip>:[[ var "port" . ]]/opds/v1.2/catalog
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Create the admin account on first visit, then add a library pointing at /data.

Volumes (Docker named):
  - [[ var "config_volume" . ]]  -> /config  (database, thumbnails, settings)
  - [[ var "library_volume" . ]] -> /data    (your comics/manga/ebooks — fill it)

Pin the job to the node holding the volumes with the constraints variable.
