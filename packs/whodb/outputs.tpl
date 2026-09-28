WhoDB deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Enter your database connection details in the UI to start exploring. Change
encryption_key before deploying anywhere real; it encrypts the saved login
sessions persisted in the data_volume. If you put WhoDB behind an HTTPS reverse
proxy, also set WHODB_SECURE=true.
