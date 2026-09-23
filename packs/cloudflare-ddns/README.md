# cloudflare-ddns

[Cloudflare DDNS](https://github.com/favonia/cloudflare-ddns) — a small, robust dynamic-DNS updater
that keeps your Cloudflare A/AAAA records pointed at your current public IP.

Background host-networked Nomad service — **no ports, no volume**. Just set your API token and
domains.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run cloudflare-ddns --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `api_token` | placeholder | `CLOUDFLARE_API_TOKEN` with Zone:DNS:Edit. **Required.** |
| `domains` | `home.example.com` | Comma-separated records to update (`DOMAINS`). **Required.** |
| `proxied` | `false` | Whether records are Cloudflare-proxied (`PROXIED`). |
| `ip6_provider` | `none` | IPv6 detection (`IP6_PROVIDER`); `none` disables AAAA updates. |
| `image` | `favonia/cloudflare-ddns:1` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 100, memory = 64 }` | Task resources. |

The records must exist in Cloudflare already; this keeps them pointed at your IP. Watch progress
with `nomad alloc logs`.
