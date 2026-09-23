# komga

[Komga](https://komga.org) — a self-hosted media server for comics, manga, and ebooks
(CBZ/CBR/PDF/EPUB) with a web reader, OPDS, and Kobo/Tachiyomi sync.

Single host-networked Nomad service with a config volume and a library volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run komga --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `25600` | Web UI port (`SERVER_PORT`). |
| `config_volume` | `komga_config` | `/config` — database, thumbnails, settings. |
| `library_volume` | `komga_library` | `/data` — your library. |
| `image` | `gotson/komga:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources (JVM). |

Create the admin on first visit and add a library at `/data` (fill that volume with your files).
See also the [audiobookshelf](../audiobookshelf) pack. Pin the job to the node holding the volumes
with `constraints`.
