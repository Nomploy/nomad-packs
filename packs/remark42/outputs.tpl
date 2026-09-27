Remark42 deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Server:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Set `remark_url` to the public URL Remark42 is served from and change `secret`
before deploying anywhere real. Embed the widget on your site by including the
remark42 script and pointing it at this host and your `site` id. To add admins
and social login (GitHub, Google, etc.), set the relevant AUTH_* env vars.
