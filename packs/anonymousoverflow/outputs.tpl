AnonymousOverflow deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Set app_url to the public URL you serve this from and change jwt_signing_secret
before deploying anywhere real. Append a Stack Overflow question URL's path to
your instance (or use a redirector extension) to read it ad- and tracker-free.
