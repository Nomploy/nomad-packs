# cloudbeaver

[CloudBeaver](https://dbeaver.com/docs/cloudbeaver/) — a browser-based database manager from the
DBeaver team. Connect to PostgreSQL, MySQL/MariaDB, SQLite, ClickHouse, and many more; browse
schemas, run SQL, and edit data.

Single host-networked Nomad service with a workspace volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run cloudbeaver --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8978` | Web UI port. |
| `data_volume` | `cloudbeaver_data` | `/opt/cloudbeaver/workspace` — connections, users, settings. |
| `image` | `dbeaver/cloudbeaver:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Run the setup wizard on first visit, then add connections (a co-located postgres/mariadb/clickhouse
pack is on `127.0.0.1`). CloudBeaver grants broad database access — keep it internal or behind auth.
Pin the job to the node holding the volume with `constraints`.
