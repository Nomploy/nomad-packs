# ytptube

[YTPTube](https://github.com/arabcoders/ytptube) — a web UI and scheduler for **yt-dlp**. Queue and manage downloads,
save format/quality presets, subscribe to channels/playlists for automatic grabs, and pull video or audio from
thousands of supported sites — all from a clean browser interface. A feature-rich take on MeTube.

Single host-networked Nomad service with config and downloads volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run ytptube --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8081` | Web UI port. |
| `image` | `ghcr.io/arabcoders/ytptube:latest` | Container image. Pin a tag in production. |
| `data_volume` | `ytptube_data` | `/config` — settings, presets and the queue database. |
| `downloads_volume` | `ytptube_downloads` | `/downloads` — downloaded media (`files/` + `tmp/`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> On first launch you create a local account. A prestart init task creates `files/` and `tmp/` under `/downloads` and
> chowns both volumes to uid `1000`. Pairs with a media server like
> [jellyfin](https://packs.nomploy.com/packs/jellyfin) or [navidrome](https://packs.nomploy.com/packs/navidrome). Pin
> the job to the node holding the volumes with `constraints`.
