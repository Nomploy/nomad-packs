SnappyMail deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Admin:     http://<node-ip>:[[ var "port" . ]]/?admin
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/var/lib/snappymail) — config + accounts; back it up

On first run open the admin panel (/?admin). The admin password is generated and written to
data/_data_/_default_/admin_password.txt inside the volume — read it from the task's filesystem,
then add your IMAP/SMTP domains. Serves plain HTTP — front it with a reverse proxy for TLS.
