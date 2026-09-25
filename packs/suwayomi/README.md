# suwayomi

[Suwayomi](https://github.com/Suwayomi/Suwayomi-Server) (a.k.a. Tachidesk) — a self-hosted **manga server** with a
web reader. It uses the same extensions as the Tachiyomi/Mihon mobile apps, so you can browse and read from many
sources, build a library, and download chapters for offline reading — all from your browser, on any device.

Single host-networked Nomad service with a persistent library volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run suwayomi --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `4567` | Web UI port. Fixed at `4567` inside the image. |
| `image` | `ghcr.io/suwayomi/suwayomi-server:stable` | Container image. Pin a tag in production. |
| `data_volume` | `suwayomi_data` | `/home/suwayomi/.local/share/Tachidesk` — library, downloads and settings. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> A prestart init task chowns the data volume to uid `1000` (Suwayomi runs unprivileged). Install source extensions
> from the web UI after first launch. Downloaded chapters read well in [komga](https://packs.nomploy.com/packs/komga)
> or [kavita](https://packs.nomploy.com/packs/kavita). Pin the job to the node holding the volume with `constraints`.
