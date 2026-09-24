# dbgate

[DBGate](https://dbgate.org) — a web-based database manager for your whole team. One GUI for MySQL,
PostgreSQL, SQL Server, MongoDB, SQLite, Redis, and more: browse and edit data, run and save queries,
design tables, and export/import between databases.

Single host-networked Nomad service with a persistent volume for saved connections and queries.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run dbgate --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3023` | Web UI port (`PORT`). |
| `data_volume` | `dbgate_data` | `/root/.dbgate` — saved connections, queries, archives. |
| `image` | `dbgate/dbgate:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Add connections from the web UI; co-located databases on the same node are reachable at
`127.0.0.1`. You can also predefine connections with `CONNECTIONS` / `LABEL_*` / `SERVER_*` env vars
(see the DBGate docs). The UI is **unauthenticated** by default — keep it internal, front it with a
reverse proxy, or set `LOGIN` / `PASSWORD` env vars to require a login. Pin the job to the node
holding the volume with `constraints`.
