Apache Pulsar deployed as job "[[ var "job_name" . ]]" (standalone, host-networked).

Binary:    pulsar://<node-ip>:[[ var "broker_port" . ]]
Admin/REST: http://<node-ip>:[[ var "http_port" . ]]   (admin API; use pulsar-admin or the HTTP endpoints)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

This is the "standalone" mode (broker + BookKeeper + metadata store in one
process) — ideal for a single node. Produce/consume on the binary port; manage
tenants/namespaces/topics via the admin REST API. Data persists in the data_volume.
For a production cluster, run ZooKeeper, BookKeeper and brokers separately.
