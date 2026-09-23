Radicale deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

CalDAV/CardDAV: http://<node-ip>:[[ var "port" . ]]
Discovery:      Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Login:          [[ var "username" . ]] / (the password you set)

Add a CalDAV/CardDAV account on your device pointing at http://<node-ip>:[[ var "port" . ]] with
those credentials; collections are created on first use. Data lives on the [[ var "data_volume" . ]]
volume (/var/lib/radicale/collections). The users file uses plaintext passwords for simplicity —
switch htpasswd_encryption to bcrypt and supply a hashed users file for production, and front with
TLS. Pin the job to the node holding the volume with the constraints variable.
