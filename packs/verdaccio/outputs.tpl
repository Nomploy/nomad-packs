Verdaccio deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI / registry: http://<node-ip>:[[ var "port" . ]]
Discovery:         Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Point npm at it and create the first user (that user becomes able to publish):
  npm set registry http://<node-ip>:[[ var "port" . ]]/
  npm adduser --registry http://<node-ip>:[[ var "port" . ]]/

Published packages + the htpasswd file live on [[ var "storage_volume" . ]]
(/verdaccio/storage). The default bundled config proxies npmjs and allows any logged-in user to
publish — mount your own /verdaccio/conf/config.yaml to lock this down. Pin the job to the node
holding the volume with the constraints variable.
