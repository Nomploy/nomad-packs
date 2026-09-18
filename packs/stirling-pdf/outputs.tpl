Stirling-PDF deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Login:     [[ if var "enable_login" . ]]enabled — set up the admin account on first visit[[ else ]]disabled (open) — keep it internal or enable login[[ end ]]

Stateless — no volume. Everything runs on this server; PDFs you upload aren't sent
elsewhere. Use a `-fat` image tag if you need OCR/extra conversions.
