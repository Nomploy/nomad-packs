# audiobookshelf

[Audiobookshelf](https://www.audiobookshelf.org) — a self-hosted audiobook and podcast server
with streaming apps for iOS/Android, progress sync, multi-user support, and podcast
auto-download.

Single host-networked Nomad service with config, metadata, and library volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run audiobookshelf --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `13378` | Web UI port (`PORT`). |
| `config_volume` | `audiobookshelf_config` | `/config` — settings + database. |
| `metadata_volume` | `audiobookshelf_metadata` | `/metadata` — covers, cache. |
| `library_volume` | `audiobookshelf_library` | `/audiobooks` — your media. |
| `image` | `ghcr.io/advplyr/audiobookshelf:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Create the admin account on first visit and add a library at `/audiobooks` (fill that volume with
your files). Pin the job to the node holding the volumes with `constraints`.
