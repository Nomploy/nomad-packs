Apache Cassandra deployed as job "[[ var "job_name" . ]]" (single-node, host-networked).

CQL:       <node-ip>:[[ var "port" . ]]   (connect with cqlsh or any driver)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Single-node with the default AllowAllAuthenticator (no auth) — fine for a trusted
network; for anything exposed, enable PasswordAuthenticator/CassandraAuthorizer.
First boot takes a minute to initialise. MAX_HEAP_SIZE is pinned so the JVM stays
within the task memory limit (Cassandra otherwise sizes the heap from host RAM).
Data persists in the data_volume at /var/lib/cassandra.
