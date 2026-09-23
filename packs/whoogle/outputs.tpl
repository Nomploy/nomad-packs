Whoogle Search deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Auth:      [[ if ne (var "username" .) "" ]]HTTP basic (user [[ var "username" . ]])[[ else ]]none (open — front with TLS/auth if internet-facing)[[ end ]]

Add it as a custom search engine in your browser:
  http://<node-ip>:[[ var "port" . ]]/search?q=%s

Stateless (preferences are per-session). Front with TLS for public use.
