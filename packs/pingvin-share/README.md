# pingvin-share

[Pingvin Share](https://github.com/stonith404/pingvin-share) — a self-hosted file-sharing platform that's
light and beautiful. Upload files and get a shareable link with optional **expiry, password, and download
limits**, or set up **reverse shares** so others can upload to you. A slick, privacy-respecting WeTransfer
alternative.

Single host-networked Nomad service using **SQLite** with persistent volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run pingvin-share --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port (`PORT`). The container listens on 3000. |
| `data_volume` | `pingvin_data` | `/opt/app/backend/data` — SQLite database and uploaded files. |
| `images_volume` | `pingvin_images` | `/opt/app/frontend/public/img` — custom logo/favicon. |
| `image` | `stonith404/pingvin-share:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

On first run, open the UI to create the admin account, then set the **App URL** and share limits in the
admin settings so links are correct. Uses named volumes (bind-mounts are known to cause permission issues).
Serves plain HTTP — front it with a reverse proxy for TLS. Pin the job to the node holding the volumes with
`constraints`.
