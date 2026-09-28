MeshCentral deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    https://<node-ip>:[[ var "port" . ]]   (self-signed cert; the FIRST account you create becomes the admin)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Set `hostname` to your node's real address/DNS name so installed agents can call
home. The first registered account is the administrator; leave allow_new_accounts
false so no one else can self-register afterwards. Config and the embedded
database (NeDB) persist in the data_volume.
