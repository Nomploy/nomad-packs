# slskd

[slskd](https://github.com/slskd/slskd) — a modern, self-hosted client for the **Soulseek** peer-to-peer
network. Run it headless and always-on with a clean web UI, search, download queue, shares, and a REST API — a
server-friendly replacement for the desktop Soulseek client.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run slskd --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `web_port` | `5030` | Web UI port (`SLSKD_HTTP_PORT`). |
| `listen_port` | `50300` | Incoming Soulseek connections (`SLSKD_SLSK_LISTEN_PORT`). Forward it for better peering. |
| `slsk_username` / `slsk_password` | `change-me` | Your Soulseek network account (`SLSKD_SLSK_*`). |
| `data_volume` | `slskd_data` | `/app` — config, database, downloads, shares. |
| `image` | `slskd/slskd:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

Set your Soulseek credentials, then open the web UI. **The web login defaults to `slskd` / `slskd`** — change
it under Options (or the config file in the volume). Serves plain HTTP — front it with a reverse proxy for TLS,
and only share content you have the rights to. Pin the job to the node holding the volume with `constraints`.
