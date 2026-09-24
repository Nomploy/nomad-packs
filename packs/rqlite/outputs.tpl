rqlite deployed as job "[[ var "job_name" . ]]" (host-networked).

HTTP API:  http://<node-ip>:[[ var "http_port" . ]]
Raft:      <node-ip>:[[ var "raft_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/rqlite/file) — SQLite DB + Raft log; back it up

Query over HTTP, e.g.:
  curl -G 'http://<node-ip>:[[ var "http_port" . ]]/db/query' --data-urlencode 'q=SELECT 1'
This is a single-node deployment (still durable). To make it highly available, run more instances with
-join pointing at this node's raft address. The API is unauthenticated — keep it internal or add auth.
