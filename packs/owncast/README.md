# owncast

[Owncast](https://owncast.online) — a self-hosted live streaming and chat server; an open-source
alternative to Twitch/YouTube Live. Stream over RTMP and viewers watch on your own page with built-in
chat.

Single host-networked Nomad service on SQLite with a data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run owncast --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web player / chat / admin. |
| `rtmp_port` | `1935` | RTMP ingest. |
| `data_volume` | `owncast_data` | `/app/data` — config, HLS segments, logs. |
| `image` | `owncast/owncast:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 512 }` | Task resources (transcoding is CPU-heavy). |

Admin is at `/admin` (default `admin` / `abc123` — **change it**, and set your stream key). Point OBS
at `rtmp://<node-ip>:1935/live`. Pin the job to the node holding the volume with `constraints`.
