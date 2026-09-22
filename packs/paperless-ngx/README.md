# paperless-ngx

[Paperless-ngx](https://docs.paperless-ngx.com) — scan, index, OCR, and archive your physical
documents into a searchable digital library with tags, correspondents, document types, and
full-text search.

All-in-one host-networked Nomad job: a **Redis** broker prestart sidecar plus the **Paperless**
app on **SQLite** (no separate database server). The Paperless image runs its own startup
migration and ownership fix, so no chown init is needed.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run paperless-ngx --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | Web UI port (`PAPERLESS_PORT`). |
| `redis_port` | `6379` | Co-located Redis broker port. |
| `admin_user` / `admin_password` | `admin` / `changeme-please` | Superuser created on first start. **Change the password.** |
| `secret_key` | placeholder | `PAPERLESS_SECRET_KEY` — set a long random value. |
| `ocr_language` | `eng` | Tesseract language(s), e.g. `deu`, `eng+deu`. |
| `timezone` | `Etc/UTC` | `PAPERLESS_TIME_ZONE`. |
| `url` | `""` | `PAPERLESS_URL`; required if exposed on a domain. |
| `data_volume` | `paperless_data` | `/usr/src/paperless/data` — SQLite DB + index. |
| `media_volume` | `paperless_media` | `/usr/src/paperless/media` — archived docs (back up). |
| `consume_volume` | `paperless_consume` | `/usr/src/paperless/consume` — drop files to import. |
| `resources` | `{ cpu = 2000, memory = 1024 }` | Paperless task resources (OCR is CPU-heavy). |

Drop documents into the consume volume (or upload via the UI) and Paperless will OCR and file
them. Pin the job to the node holding the volumes with `constraints`.
