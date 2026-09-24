# dolt

[Dolt](https://www.dolthub.com) — "Git for data." A SQL database with real version control: branch,
diff, merge, and clone your **data and schema**, with full commit history. It speaks the **MySQL wire
protocol**, so existing clients, drivers, and ORMs connect unchanged.

Single host-networked Nomad service running `dolt sql-server` with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run dolt --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3306` | MySQL-compatible SQL port. |
| `root_password` | `change-me-please` | Root password (`DOLT_ROOT_PASSWORD`). **Change it.** |
| `data_volume` | `dolt_data` | `/var/lib/dolt` — all databases, branches, and history. |
| `image` | `dolthub/dolt-sql-server:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Connect with any MySQL client (`mysql -h <node-ip> -P 3306 -u root -p`), then use Dolt's
version-control SQL — `CALL DOLT_COMMIT('-am','message')`, `DOLT_BRANCH()`, `DOLT_MERGE()`, and the
`dolt_diff_*` / `dolt_log` system tables. Root connects from localhost (same-node clients use
`127.0.0.1`); to allow remote root, add `DOLT_ROOT_HOST` to the task. Serves an **unencrypted** SQL
port — keep it on an internal network or front it with TLS. Pin the job to the node holding the volume
with `constraints`.
