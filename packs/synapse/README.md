# synapse

[Synapse](https://github.com/element-hq/synapse) — the reference **Matrix homeserver** for secure, decentralized,
end-to-end-encrypted chat. Run your own homeserver and connect with any Matrix client (Element, etc.). This pack runs
Synapse with an embedded **SQLite** database and **auto-generates** its config on first start.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run synapse --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8008` | Client-server API port (Synapse's default). |
| `server_name` | `localhost` | **Set before first start.** Your Matrix domain — becomes part of every user ID and **cannot change later**. |
| `report_stats` | `no` | Report anonymous usage stats (`yes`/`no`). |
| `image` | `matrixdotorg/synapse:latest` | Container image. Pin a tag in production. |
| `data_volume` | `synapse_data` | `/data` — config, keys, media and the SQLite database. |
| `resources` | `{ cpu = 500, memory = 1024 }` | Task resources. |

> **Pick `server_name` carefully** (ideally your real domain) — it's fixed for the life of the server. On first start
> Synapse generates `homeserver.yaml` and signing keys into the volume; a prestart init task makes it writable. Create
> users with `register_new_matrix_user` (exec into the task). For federation and production, front it with a reverse
> proxy over TLS and switch to PostgreSQL. Pin the job to the node holding the volume with `constraints`.
