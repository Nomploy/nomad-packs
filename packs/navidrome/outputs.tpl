Navidrome deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Subsonic:  same host/port (Subsonic / OpenSubsonic API for mobile apps)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Create the admin account on first visit.

Volumes (Docker named):
  - [[ var "data_volume" . ]]  -> /data   (database, cache, cover art)
  - [[ var "music_volume" . ]] -> /music  (read-only; put your library here)

The music volume starts empty — populate it (host copy, the syncthing pack, etc.),
then trigger a scan from Settings. Pin the job to the node holding the volumes with
the constraints variable.
