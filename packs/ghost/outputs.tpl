Ghost deployed as job "[[ var "job_name" . ]]" (Ghost + MySQL 8, host-networked).

Site:      [[ if ne (var "url" .) "" ]][[ var "url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]
Admin:     [[ if ne (var "url" .) "" ]][[ var "url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]/ghost  (create the owner account on first visit)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on port [[ var "port" . ]]
State:     volumes "[[ var "db_data_volume" . ]]" (MySQL) + "[[ var "content_volume" . ]]" (themes/images) — back both up

Set `url` to your real public URL (Ghost bakes it into links) and front with a reverse
proxy for TLS. Configure SMTP in Ghost for member/newsletter email.
