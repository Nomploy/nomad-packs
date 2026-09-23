Gotenberg deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API:       http://<node-ip>:[[ var "port" . ]]
Health:    http://<node-ip>:[[ var "port" . ]]/health
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Stateless — no volumes, safe to scale via `count`. Example:
  curl --request POST http://<node-ip>:[[ var "port" . ]]/forms/chromium/convert/url \
    --form url=https://example.com -o out.pdf

The API has no authentication — keep it on an internal network or front it with a reverse proxy.
Point paperless-ngx, Docmost, or your own app at it for document conversion.
