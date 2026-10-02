Dgraph deployed as job "[[ var "job_name" . ]]" (standalone, host-networked).

HTTP/GraphQL: http://<node-ip>:[[ var "http_port" . ]]   (admin: /admin, GraphQL: /graphql, DQL: /query)
gRPC:         <node-ip>:[[ var "grpc_port" . ]]   (for client libraries)
Discovery:    Nomad service "[[ var "job_name" . ]]" (provider=nomad)

This is the "standalone" image (Zero + Alpha in one container) — great for a
single node; for a production cluster run Zero and Alpha separately with
replication. Load a GraphQL schema via POST /admin/schema, then query at
/graphql. Data persists in the data_volume at /dgraph.
