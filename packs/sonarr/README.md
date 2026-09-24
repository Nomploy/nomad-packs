# sonarr

[Sonarr](https://sonarr.tv) — a PVR for **TV series**. Monitor the shows you follow, automatically grab new
episodes from your indexers through a download client, then rename and organize them into your library. Handles
quality profiles, upgrades, and release management.

Single host-networked Nomad service with config and media volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run sonarr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8989` | Web UI port. |
| `config_volume` | `sonarr_config` | `/config` — database and settings. |
| `data_volume` | `media_data` | `/data` — TV library + downloads. **Share this with your download client and media server.** |
| `puid` / `pgid` | `1000` / `1000` | User/group (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `lscr.io/linuxserver/sonarr:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Connect the `prowlarr` pack for indexers and the `qbittorrent` pack as the download client, and set your root
folder to `/data/tv`. **Keep Sonarr, the download client, and your media server (`jellyfin`) on the same `/data`
volume** so imports use fast hardlinks/atomic moves. Serves plain HTTP — front it with a reverse proxy for TLS.
Pin the job to the node holding the volumes with `constraints`.
