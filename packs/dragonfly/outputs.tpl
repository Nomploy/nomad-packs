Dragonfly deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Endpoint:  <node-ip>:[[ var "port" . ]]  (Redis protocol — any redis client works)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (snapshots) — back it up
Auth:      [[ if ne (var "password" .) "" ]]password set (requirepass)[[ else ]]none (open) — set password for auth[[ end ]]

Drop-in for Redis/Memcached — point your client at <node-ip>:[[ var "port" . ]]. Give it real
memory (4GB+ recommended). If it fails to start on an older kernel, your node may need the
docker privileged option enabled.
