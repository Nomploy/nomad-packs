copyparty deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
WebDAV/FTP: same host (see the copyparty docs to enable FTP/TFTP)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Files:     Docker volume "[[ var "data_volume" . ]]" (/w) · Config: "[[ var "config_volume" . ]]" (/cfg)

The /w volume is shared with anonymous access "[[ var "share_mode" . ]]". To add user accounts and
per-path permissions, drop a .conf file into the /cfg volume (see copyparty's example configs) — it is
loaded automatically. Serves plain HTTP — front it with a reverse proxy for TLS or keep it internal.
