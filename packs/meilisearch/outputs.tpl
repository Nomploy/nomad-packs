Meilisearch deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API:       http://<node-ip>:[[ var "port" . ]]  (health: /health)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" — back it up
Auth:      [[ if ne (var "master_key" .) "" ]]production mode — send "Authorization: Bearer <master_key>"[[ else ]]DEVELOPMENT mode — OPEN, no auth. Set master_key for production.[[ end ]]

Try it:
  curl http://<node-ip>:[[ var "port" . ]]/health
[[ if ne (var "master_key" .) "" ]]  curl -H "Authorization: Bearer <master_key>" http://<node-ip>:[[ var "port" . ]]/keys[[ end ]]
