# radarr

[Radarr](https://radarr.video) — a PVR for **movies**. Monitor films, automatically grab them from your indexers
through a download client, then rename and organize them into your library with quality profiles and upgrades.

Single host-networked Nomad service with config and media volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run radarr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `7878` | Web UI port. |
| `config_volume` | `radarr_config` | `/config` — database and settings. |
| `data_volume` | `media_data` | `/data` — movie library + downloads. **Share this with your download client and media server.** |
| `puid` / `pgid` | `1000` / `1000` | User/group (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `lscr.io/linuxserver/radarr:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Connect the `prowlarr` pack for indexers and the `qbittorrent` pack as the download client, and set your root
folder to `/data/movies`. **Keep Radarr, the download client, and your media server (`jellyfin`) on the same
`/data` volume** so imports use fast hardlinks/atomic moves. Serves plain HTTP — front it with a reverse proxy for
TLS. Pin the job to the node holding the volumes with `constraints`.
