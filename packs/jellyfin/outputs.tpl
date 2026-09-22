Jellyfin deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Complete the setup wizard on first visit and create your admin user.

Volumes (Docker named):
  - [[ var "config_volume" . ]] -> /config  (config, metadata, database)
  - [[ var "cache_volume" . ]]  -> /cache   (transcode/cache)
  - [[ var "media_volume" . ]]  -> /media   (read-only; your library)

The media volume starts empty — populate it and add "/media" as a library. Jellyfin binds
port [[ var "port" . ]]; to change it, use Dashboard -> Networking after first run (and update
the port variable to match). Hardware transcoding needs device access (not configured here);
raise resources.cpu for software transcoding. Pin the job to the node holding the volumes.
