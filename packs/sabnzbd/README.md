# sabnzbd

[SABnzbd](https://sabnzbd.org) — a powerful, fully-automated **Usenet (NZB)** download client with a web UI: queue
management, automatic par2 repair and unpacking, categories, scheduling, and an API the *arr apps use. The Usenet
counterpart to the `qbittorrent` (torrent) pack.

Single host-networked Nomad service with config and downloads volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run sabnzbd --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI port. The container listens on 8080. |
| `config_volume` | `sabnzbd_config` | `/config` — settings and history. |
| `data_volume` | `media_data` | `/data` — downloads. **Share with the *arr packs.** |
| `puid` / `pgid` | `1000` / `1000` | User/group (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `lscr.io/linuxserver/sabnzbd:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 512 }` | Task resources. Repair/unpack are CPU-bound. |

Run the setup wizard, add your Usenet provider, and set download folders under `/data`. Connect it as the download
client in `sonarr` / `radarr` / `lidarr`, sharing the same `/data` volume for hardlinks.

> If you access SABnzbd by a hostname and get an "Access denied / refused" page, add that hostname to
> `host_whitelist` in `/config/sabnzbd.ini`. Serves plain HTTP — front it with a reverse proxy for TLS.
