# convertx

[ConvertX](https://github.com/C4illin/ConvertX) — a self-hosted **file converter** with a clean web UI. It supports
1000+ formats across images, documents, audio, video, ebooks and more (backed by tools like FFmpeg, ImageMagick,
Pandoc, Calibre and libvips), converts multiple files at once, and keeps everything on your own server.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run convertx --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port. |
| `jwt_secret` | `change-me-…` | **Change this.** Signs session tokens. `openssl rand -base64 36`. |
| `image` | `ghcr.io/c4illin/convertx:latest` | Container image. Pin a tag in production. |
| `data_volume` | `convertx_data` | `/app/data` — SQLite database and converted files. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Bump for large video conversions. |

> **First run:** the first account you create becomes the admin; registration is then closed by default. A prestart
> init task chowns the data volume to `PUID:PGID`. Pin the job to the node holding the volume with `constraints`.
