cloudflared deployed as job "[[ var "job_name" . ]]" ([[ var "count" . ]] connector(s), host-networked).

The tunnel connects outbound to Cloudflare — no inbound ports are opened here. Manage which
public hostnames route to which local services (e.g. http://127.0.0.1:8080) in the
Cloudflare Zero Trust dashboard (Networks → Tunnels).

Check status:  in the dashboard the tunnel should show "HEALTHY".
[[ if eq (var "tunnel_token" .) "" ]]NOTE: tunnel_token is empty — set it or the connector can't start.[[ end ]]
