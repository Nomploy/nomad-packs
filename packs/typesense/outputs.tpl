Typesense deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API:       http://<node-ip>:[[ var "port" . ]]  (health: /health)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" — back it up
Auth:      send header  X-TYPESENSE-API-KEY: <api_key>

Quick check:
  curl http://<node-ip>:[[ var "port" . ]]/health
  curl -H "X-TYPESENSE-API-KEY: <api_key>" http://<node-ip>:[[ var "port" . ]]/collections
