# calibre-web-automated

[Calibre-Web Automated](https://github.com/crocodilestick/Calibre-Web-Automated) (CWA) — a supercharged
[Calibre-Web](https://packs.nomploy.com/packs/calibre-web). On top of the familiar in-browser reader and OPDS server it
**auto-ingests** ebooks dropped into a watch folder: converting formats, fixing metadata and covers, and filing them
into your library automatically. A hands-off way to run a personal ebook library.

Single host-networked Nomad service with config, library and ingest volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run calibre-web-automated --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8083` | Web UI port (`CWA_PORT_OVERRIDE`). |
| `image` | `crocodilestick/calibre-web-automated:latest` | Container image. Pin a tag in production. |
| `data_volume` | `…_data` | `/config` — settings and app database. |
| `library_volume` | `…_library` | `/calibre-library` — the Calibre library (auto-created if empty). |
| `ingest_volume` | `…_ingest` | `/cwa-book-ingest` — drop ebooks here to auto-import. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Default login is `admin` / `admin123` — change it immediately. Unlike plain Calibre-Web, CWA sets up a library for you
> on first run, so you can start dropping books into the ingest folder right away. Pin the job to the node holding the
> volumes with `constraints`.
