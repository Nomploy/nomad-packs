Mumble server deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Connect: <node-ip>:[[ var "port" . ]]  (TCP + UDP) from any Mumble client
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Log in as "SuperUser" with the superuser_password you set to administer channels, ACLs, and
registrations. The server database and config live on the [[ var "data_volume" . ]] volume (/data) —
back it up and pin the job to that node with the constraints variable. For internet use, forward
TCP+UDP [[ var "port" . ]].
