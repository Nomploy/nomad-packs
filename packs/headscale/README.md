# headscale

[Headscale](https://headscale.net) — an open-source, self-hosted implementation of the Tailscale
control server. Run your own coordination server for a WireGuard mesh VPN, independent of
Tailscale's SaaS.

Host-networked Nomad service with a rendered `config.yaml` and a SQLite data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run headscale --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | HTTP/control endpoint. |
| `metrics_port` | `9099` | Prometheus metrics endpoint. |
| `server_url` | `""` | **Public URL clients connect to** — must be reachable by your devices. |
| `base_domain` | `headscale.internal` | MagicDNS base domain. |
| `data_volume` | `headscale_data` | `/var/lib/headscale` — SQLite DB + keys. |
| `image` | `headscale/headscale:0.23.0` | Pinned — the config schema is version-specific. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Set `server_url`** to a URL your devices can reach (`http://<node-ip>:8080` or a TLS domain).
> The config is pinned to the image version — if you bump `image`, review `config.yaml` for schema
> changes.

## Enrol a device

```sh
nomad alloc exec -task headscale <alloc> headscale users create myuser
tailscale up --login-server=<server_url> --accept-routes
nomad alloc exec -task headscale <alloc> headscale nodes register --user myuser --key <nodekey>
```

Pin the job to the node holding the volume with `constraints`.
