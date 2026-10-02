Documenso deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Bundled: PostgreSQL (prestart sidecar, port [[ var "db_port" . ]]) and a self-signed
signing certificate generated once by the cert-init task into the documenso_cert volume.
Uploads are stored in the database (NEXT_PUBLIC_UPLOAD_TRANSPORT=database). Database
migrations run automatically on first start; create the first account in the UI.

CHANGE nextauth_secret, encryption_key, encryption_secondary_key and db_password before
deploying anywhere real, and keep the three secrets stable. Set webapp_url to the public
URL. To send signing emails, set smtp_host / smtp_username / smtp_password (transport
smtp-auth). The bundled certificate is self-signed — for legally recognized signatures,
replace it with your own CA-issued PKCS#12 cert in the documenso_cert volume.
