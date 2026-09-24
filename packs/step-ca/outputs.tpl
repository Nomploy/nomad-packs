step-ca deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

CA API:    https://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/home/step: config, certs, KEYS) — back it up securely

On first boot the CA auto-initializes with your settings. Get the root fingerprint from the task logs
(or run `step certificate fingerprint` on /home/step/certs/root_ca.crt), then bootstrap clients:
  step ca bootstrap --ca-url https://<dns-name>:[[ var "port" . ]] --fingerprint <fp>
Point ACME clients (Caddy, cert-manager, certbot) at https://<dns-name>:[[ var "port" . ]]/acme/acme/directory.
Keep the CA password and the /home/step volume safe — they are the trust root of your PKI.
