Kafka deployed as job "[[ var "job_name" . ]]" (single-node KRaft, host-networked).

Bootstrap server: [[ var "advertised_host" . ]]:[[ var "port" . ]]
Discovery:        Nomad service "[[ var "job_name" . ]]" (provider=nomad)

This is a single-node KRaft broker (no ZooKeeper). For clients outside the node
to connect, set `advertised_host` to the node's reachable address/DNS name and
redeploy — otherwise only local (localhost) clients can reach it. Log data
persists in the data_volume at /var/lib/kafka/data.
