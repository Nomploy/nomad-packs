Neo4j deployed as job "[[ var "job_name" . ]]" (host-networked).

Browser:   http://<node-ip>:[[ var "http_port" . ]]  (login neo4j / <password>)
Bolt:      bolt://<node-ip>:[[ var "bolt_port" . ]]  (drivers connect here)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on the HTTP port
Data:      Docker volume "[[ var "data_volume" . ]]" (graph store) — back it up

The initial password is set on first boot (must be >= 8 chars and not "neo4j"). Front with a
reverse proxy for TLS; no auth changes take effect after the DB is initialized (use Cypher).
