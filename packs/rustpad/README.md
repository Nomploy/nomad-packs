# rustpad

[Rustpad](https://github.com/ekzhang/rustpad) — a small, fast **collaborative text editor**. Open a link and several
people edit the same document together in real time, with live cursors — no account needed. Great for quick shared
notes, pair-coding scratchpads and interviews.

Single host-networked Nomad service. This pack enables SQLite persistence so documents survive restarts.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run rustpad --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3030` | Web UI port (`PORT`). |
| `expiry_days` | `1` | Days a document is kept after its last edit before garbage collection (`EXPIRY_DAYS`). |
| `image` | `ekzhang/rustpad:latest` | Container image. Pin a tag in production. |
| `data_volume` | `rustpad_data` | `/data` — SQLite persistence (`SQLITE_URI=/data/rustpad.db`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Rustpad is very lightweight. |

> Documents are addressed by the URL fragment (e.g. `/#my-doc`) — anyone with the link can edit, so put Rustpad
> behind an authenticating reverse proxy if it shouldn't be public. Pin the job to the node holding the volume with
> `constraints`. Raise `expiry_days` to keep pads around longer.
