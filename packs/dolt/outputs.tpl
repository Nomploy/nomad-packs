Dolt SQL server deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Connect:   mysql -h <node-ip> -P [[ var "port" . ]] -u root -p
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/var/lib/dolt) — all databases + history; back it up

Speaks the MySQL wire protocol, so any MySQL client, driver, or ORM works. Then use Dolt's
version-control SQL: CALL DOLT_COMMIT('-am','msg'), DOLT_BRANCH(), DOLT_MERGE(), and the
dolt_diff / dolt_log system tables. Root connects from localhost (same-node clients use 127.0.0.1);
to allow remote root, add DOLT_ROOT_HOST to the dolt task. Serves an unencrypted SQL port — keep it
internal or front it with TLS.
