# kavita

[Kavita](https://www.kavitareader.com) — a fast, self-hosted digital library and reading server for
**manga, comics, ebooks (EPUB/PDF), and magazines**. Ships a slick web reader, collections and
reading lists, per-user reading progress, OPDS, and multi-user accounts.

Single host-networked Nomad service with a config volume and a library volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run kavita --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5000` | Web UI port. The container listens on 5000. |
| `config_volume` | `kavita_config` | `/kavita/config` — SQLite DB, covers, bookmarks, backups. |
| `library_volume` | `kavita_library` | `/data` — the files Kavita scans (manga/comics/books). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `jvmilazz0/kavita:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

On first run, open the UI to create the admin account, then add libraries pointing at folders under
`/data`. To use existing media, copy it into the library volume or replace that mount with a bind to
your media directory. Serves plain HTTP — front it with a reverse proxy for TLS. Pin the job to the
node holding the volumes with `constraints`.
