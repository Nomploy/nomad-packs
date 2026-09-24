# qbittorrent

[qBittorrent](https://www.qbittorrent.org) — a full-featured, ad-free BitTorrent client with a clean web UI,
categories, RSS auto-downloading, sequential downloading, and a rich API. Runs headless as an always-on download
client — the standard companion for the `sonarr` / `radarr` packs.

Single host-networked Nomad service with config and downloads volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run qbittorrent --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8090` | Web UI port (`WEBUI_PORT`). |
| `torrent_port` | `6881` | Incoming BitTorrent port (TCP+UDP). Forward it for better peering. |
| `config_volume` | `qbittorrent_config` | `/config` — settings and session. |
| `data_volume` | `media_data` | `/data` — downloads. **Share with the *arr packs and media server.** |
| `puid` / `pgid` | `1000` / `1000` | User/group (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `lscr.io/linuxserver/qbittorrent:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

**First boot:** a temporary admin password is printed in the task logs (`nomad alloc logs`) — log in and change
it in Settings. Set the save path under `/data/downloads`, and keep the `/data` volume shared with `sonarr`,
`radarr`, and `jellyfin` so imports use fast hardlinks. Use it only for content you're entitled to; front the web
UI with a reverse proxy for TLS. Pin the job to the node holding the volumes with `constraints`.
