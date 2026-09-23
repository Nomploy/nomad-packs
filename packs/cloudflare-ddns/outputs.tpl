Cloudflare DDNS deployed as job "[[ var "job_name" . ]]" (background updater — no web UI, no ports).

Updating: [[ var "domains" . ]]  (proxied: [[ var "proxied" . ]])

It checks your public IP on a schedule and updates the matching Cloudflare A[[ if ne (var "ip6_provider" .) "none" ]]/AAAA[[ end ]] records.
Watch it work:
  nomad alloc logs -task cloudflare-ddns <alloc>

Set api_token to a Cloudflare API token with Zone:DNS:Edit, and domains to the records you own.
The records must already exist in Cloudflare (create them once, then this keeps them current).
