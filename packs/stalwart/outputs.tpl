Stalwart deployed as job "[[ var "job_name" . ]]" (host-networked).

Admin / setup UI: http://<node-ip>:[[ var "admin_port" . ]]   (login: [[ var "admin_user" . ]] / the admin_password you set)
Mail:  SMTP [[ var "smtp_port" . ]] · submission [[ var "submission_port" . ]]/[[ var "submissions_port" . ]] · IMAP [[ var "imap_port" . ]]/[[ var "imaps_port" . ]] · Sieve [[ var "sieve_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

On first start Stalwart runs in bootstrap mode on the admin port with the
recovery admin you pinned. Open the admin UI, add your domain and accounts, set
up TLS (ACME) and DNS (MX/SPF/DKIM/DMARC). Change admin_password before
deploying anywhere real, and pin this to a node with your mail hostname's public
IP and reverse DNS. Config, mailboxes and queue persist in the data_volume.
