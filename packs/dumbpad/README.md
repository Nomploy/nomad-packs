# dumbpad

[DumbPad](https://github.com/DumbWareio/DumbPad) — a stupidly simple, **no-database notepad** in your browser. Open it,
type, and it autosaves; keep multiple named notes, switch between them, and optionally lock it behind a PIN. No
accounts, no clutter — just a scratchpad that persists to disk.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run dumbpad --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port (`PORT`). |
| `pin` | `""` | Optional PIN, 4–10 digits (`DUMBPAD_PIN`). Empty = no auth. |
| `base_url` | `""` | Public URL (`BASE_URL`). Empty = `http://localhost:<port>`. |
| `site_title` | `DumbPad` | Header title (`SITE_TITLE`). |
| `image` | `dumbwareio/dumbpad:latest` | Container image. Pin a tag in production. |
| `data_volume` | `dumbpad_data` | `/app/data` — your notes. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Set a `pin` (or put it behind an authenticating reverse proxy) before exposing it — with no PIN, anyone who can
> reach the port can read and edit your notes. A prestart init task chowns the data volume to uid `1000`. Pin the job
> to the node holding the volume with `constraints`.
