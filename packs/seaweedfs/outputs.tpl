SeaweedFS deployed as job "[[ var "job_name" . ]]" (single-node all-in-one, host-networked).

S3 API:    http://<node-ip>:[[ var "s3_port" . ]]   (point your S3 client here; path-style)
Master UI: http://<node-ip>:[[ var "master_port" . ]]
Filer UI:  http://<node-ip>:[[ var "filer_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on the S3 port
State:     Docker volume "[[ var "data_volume" . ]]" (object data + metadata — back this up)
Auth:      [[ if and (ne (var "access_key" .) "") (ne (var "secret_key" .) "") ]]enabled (access_key "[[ var "access_key" . ]]" / <secret_key>)[[ else ]]OPEN — anonymous Allow-All. Set access_key + secret_key to require auth.[[ end ]]

Quick test (with the AWS CLI, path-style addressing):
  aws --endpoint-url http://<node-ip>:[[ var "s3_port" . ]] s3 mb s3://test
  aws --endpoint-url http://<node-ip>:[[ var "s3_port" . ]] s3 ls
