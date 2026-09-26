# dumbdrop

[DumbDrop](https://github.com/DumbWareio/DumbDrop) — a stupidly simple **drag-and-drop file uploader**. Share a link,
let people drop files straight into a folder on your server, with optional PIN protection, upload notifications and a
configurable size limit. No accounts, no database — just a clean upload page.

Single host-networked Nomad service with a persistent uploads volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run dumbdrop --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port (`PORT`). |
| `pin` | `""` | Optional PIN, 4–10 digits (`DUMBDROP_PIN`). Empty = no auth. |
| `base_url` | `""` | Public URL (`BASE_URL`) — **must end with a trailing slash**. Empty = `http://localhost:<port>/`. |
| `max_file_size` | `1024` | Maximum upload size in MB (`MAX_FILE_SIZE`). |
| `image` | `dumbwareio/dumbdrop:latest` | Container image. Pin a tag in production. |
| `data_volume` | `dumbdrop_data` | `/app/uploads` — uploaded files. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> `BASE_URL` must end with a trailing slash or the app won't start (the pack's default already does). Set a `pin` (or a
> reverse proxy) before exposing it publicly. A prestart init task chowns the uploads volume to uid `1000`. Pin the job
> to the node holding the volume with `constraints`.
