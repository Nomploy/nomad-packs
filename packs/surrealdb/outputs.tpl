SurrealDB deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Endpoint:  http://<node-ip>:[[ var "port" . ]]  (HTTP + WebSocket /rpc; health at /health)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Root:      user "[[ var "root_user" . ]]" / <root_password>  (persisted on first start)
Data:      Docker volume "[[ var "data_volume" . ]]" (RocksDB) — back it up

Query with the surreal CLI or any HTTP client:
  surreal sql --endpoint http://<node-ip>:[[ var "port" . ]] --user [[ var "root_user" . ]] --pass <pw> --ns test --db test
