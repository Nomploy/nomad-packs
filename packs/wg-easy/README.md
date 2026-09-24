# wg-easy

[wg-easy](https://github.com/wg-easy/wg-easy) — the easiest way to run your own **WireGuard VPN**. Create and
manage clients from a clean web UI, show QR codes to set up phones in seconds, and watch live traffic. Your own
private tunnel back to home/lab, no third party.

Single host-networked Nomad service with the `NET_ADMIN` capability, IP forwarding enabled, and a persistent
config volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run wg-easy --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `wg_host` | `vpn.example.com` | `WG_HOST` — your server's **public** IP/hostname. **Set this.** |
| `password` | `change-me-please` | Web UI password (`PASSWORD`). **Change it.** |
| `web_port` | `51821` | Web UI port (`PORT`). |
| `wg_port` | `51820` | WireGuard UDP port (`WG_PORT`). Must be reachable from the internet. |
| `data_volume` | `wg_easy_data` | `/etc/wireguard` — keys and client configs. |
| `image` | `ghcr.io/wg-easy/wg-easy:14` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 128 }` | Task resources. |

Set `wg_host` to your public address and **forward UDP `wg_port`** to this node. Create clients in the web UI and
scan the QR code on mobile. The job adds `NET_ADMIN` + `SYS_MODULE` and enables `net.ipv4.ip_forward` so traffic
routes through the tunnel. Front the **web UI** with a reverse proxy for TLS and never expose it without a
password. Pin the job to the node holding the volume with `constraints`.
