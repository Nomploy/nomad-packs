# wakapi

[Wakapi](https://wakapi.dev) — a self-hosted coding-statistics server compatible with **WakaTime**.
Your editor plugins report activity here and you get dashboards of time spent per language, project,
and editor.

Single host-networked Nomad service on SQLite with a data volume. A busybox prestart task chowns the
data volume to Wakapi's UID.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run wakapi --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3016` | Web UI / API port (`WAKAPI_PORT`). |
| `password_salt` | placeholder | `WAKAPI_PASSWORD_SALT` — set a long random value. |
| `uid` | `1000` | User Wakapi runs as; data volume is chown'd to it. |
| `data_volume` | `wakapi_data` | `/data` — SQLite database. |
| `image` | `ghcr.io/muety/wakapi:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

Sign up, grab your API key, and point your editor's WakaTime plugin at
`http://<node-ip>:<port>/api`. Pin the job to the node holding the volume with `constraints`.
