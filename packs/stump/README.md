# stump

[Stump](https://www.stumpapp.dev) — a fast, self-hosted server for **comics, manga, and ebooks**, written in
Rust with a tiny footprint. Slick web reader, OPDS support for third-party reader apps, reading progress, and
multi-user libraries.

Single host-networked Nomad service with a config volume and a library volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run stump --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `10801` | Web UI port (`STUMP_PORT`). |
| `config_volume` | `stump_config` | `/config` — SQLite DB, thumbnails, logs. |
| `library_volume` | `stump_library` | `/data` — the files Stump scans (comics/manga/books). |
| `puid` / `pgid` | `1000` / `1000` | User/group Stump runs as (`PUID`/`PGID`). |
| `image` | `aaronleopold/stump:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

On first run, create the admin account, then add libraries pointing at folders under `/data`. Read in the
browser or via any OPDS app. To use existing media, copy it into the library volume or replace that mount with a
bind to your media directory. A lighter, Rust-based sibling to the `komga` and `kavita` packs. Serves plain
HTTP — front it with a reverse proxy for TLS. Pin the job to the node holding the volumes with `constraints`.
