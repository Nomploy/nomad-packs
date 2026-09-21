# cloudflared

[Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/)
via `cloudflared` — expose your Nomad services to the internet over an **outbound-only**
connection: no open inbound ports, no public IP, no port-forwarding. Cloudflare terminates
TLS and routes your chosen hostnames to local services. Stateless host-networked Nomad
service.

## Usage

1. In the **Cloudflare Zero Trust** dashboard: Networks → Tunnels → create a tunnel, copy
   its **token**, and add public hostname → service routes (e.g.
   `app.example.com` → `http://127.0.0.1:8080`).
2. Deploy the connector with that token:

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run cloudflared --registry nomploy --var tunnel_token=<your-token>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `cloudflared`, set
`tunnel_token`, then Deploy. The tunnel should show **HEALTHY** in the dashboard.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `cloudflare/cloudflared:latest` | Pin a tag in production. |
| `tunnel_token` | `""` | **Required** — the tunnel's token (a secret). |
| `count` | `1` | Replicas; 2+ gives HA (Cloudflare load-balances connectors). |
| `constraints` | `[]` | Placement. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- **Stateless** — all config lives in the token / Cloudflare dashboard. Because it uses
  host networking, the connector reaches services on `127.0.0.1:<port>`; route hostnames to
  those local addresses in the dashboard.
- **Outbound only** — no inbound ports are opened on your nodes.
- Keep the token secret; anyone with it can run your tunnel.
