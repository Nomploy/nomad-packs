Valkey deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Endpoint:  <node-ip>:[[ var "port" . ]]  (Redis protocol — any redis/valkey client works)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (AOF) — back it up
Auth:      [[ if ne (var "password" .) "" ]]password set (requirepass)[[ else ]]none (open) — set password for auth[[ end ]]

Drop-in for Redis: point your app's redis client at <node-ip>:[[ var "port" . ]].
