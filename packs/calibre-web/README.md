# calibre-web

[Calibre-Web](https://github.com/janeczku/calibre-web) — a clean, modern web app for browsing, reading and
downloading books from an existing **Calibre** library. It serves an in-browser reader, an OPDS feed for reading
apps, user accounts, and optional on-the-fly format conversion — without needing the Calibre desktop app running.

Single host-networked Nomad service with persistent config and library volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run calibre-web --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8083` | Web UI port. Fixed inside the LinuxServer image — keep the container reachable on `8083`. |
| `image` | `lscr.io/linuxserver/calibre-web:latest` | Container image. Pin a tag in production. |
| `data_volume` | `calibre_web_data` | `/config` — settings and the app database. |
| `books_volume` | `calibre_web_books` | `/books` — your Calibre library. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Needs a Calibre library:** on first run, Calibre-Web asks for the path to a `metadata.db`. The `/books` volume
> must already contain a Calibre library (a `metadata.db` produced by the Calibre desktop app or `calibredb`). If
> you start from an empty volume, create the library first, e.g. `calibredb add --with-library /books <file>`.

> **First login:** default credentials are `admin` / `admin123` — change them immediately. Put Calibre-Web behind an
> authenticating reverse proxy over TLS before exposing it. Pin the job to the node holding the volumes with
> `constraints`.
