# filestash

[Filestash](https://www.filestash.app) — a web file manager and universal front-end for your storage.
Browse, upload, preview, and edit files across **S3, SFTP, FTP, WebDAV, Git, local disk** and more, all
from one clean UI, with sharing links, an org-mode/markdown editor, and image/video/office previews.

Single host-networked Nomad service with a persistent config/state volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run filestash --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8334` | Web UI port. The container listens on 8334. |
| `application_url` | `""` | `APPLICATION_URL` — set to your public URL so share links are correct. |
| `data_volume` | `filestash_data` | `/app/data/state` — admin config, SQLite, search index. |
| `image` | `machines/filestash:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

On first run, open `/admin` to set the admin password, then add storage backends. Filestash is a
front-end — it connects to storage you already have (great paired with the `seaweedfs` or `minio` packs
over S3). Serves plain HTTP — front it with a reverse proxy for TLS. Pin the job to the node holding the
volume with `constraints`.
