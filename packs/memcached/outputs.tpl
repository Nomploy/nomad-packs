Memcached deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Endpoint:  <node-ip>:[[ var "port" . ]]  (memcached protocol)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Cache:     up to [[ var "memory_limit" . ]] MB, LRU eviction — purely in-memory, nothing persists.

Point your app's memcached client at <node-ip>:[[ var "port" . ]].
