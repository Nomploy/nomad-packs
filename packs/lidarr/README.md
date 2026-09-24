# lidarr

[Lidarr](https://lidarr.audio) — a PVR for **music**. Monitor artists and albums, automatically grab releases from
your indexers through a download client, then tag and organize them into your library with quality profiles.

Single host-networked Nomad service with config and media volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run lidarr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8686` | Web UI port. |
| `config_volume` | `lidarr_config` | `/config` — database and settings. |
| `data_volume` | `media_data` | `/data` — music library + downloads. **Share with your download client and music server.** |
| `puid` / `pgid` | `1000` / `1000` | User/group (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `lscr.io/linuxserver/lidarr:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Connect the `prowlarr` pack for indexers and the `qbittorrent` pack as the download client, and set your root
folder to `/data/music`. **Keep Lidarr, the download client, and the `navidrome` pack on the same `/data` volume**
for fast hardlinks. Serves plain HTTP — front it with a reverse proxy for TLS. Pin the job to the node holding the
volumes with `constraints`.
