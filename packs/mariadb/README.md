# mariadb

[MariaDB](https://mariadb.org) — the community-developed, fully open-source drop-in
replacement for MySQL — as a host-networked Nomad service with a persistent Docker
volume. Use it to back apps that expect MySQL/MariaDB (WordPress, Ghost, Matomo, …).

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run mariadb --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `mariadb`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Connect at `<node-ip>:3306` as `db_user` / `db_password` (database `db_name`), or as
`root` / `root_password`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `mariadb:11` | Pin a tag in production. |
| `port` | `3306` | Host port. |
| `db_name` / `db_user` / `db_password` | `app` / `app` / `mariadb` | App database + user created on first boot. **Change the password.** |
| `root_password` | `mariadb` | **Change this.** |
| `data_volume` | `mariadb_data` | Persistent `/var/lib/mysql`. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise memory for larger workloads. |

## Notes

- **Single node.** Keep `count` at 1 — storage is a local volume with no built-in
  replication. Pin the job with `constraints` so it lands on the node holding the volume.
- Credentials/database are applied **only on first boot** (empty data dir). Changing them
  later means `ALTER USER` inside the DB, not just editing the job.
- **Backups:** snapshot the `data_volume`, or run `mysqldump` / `mariadb-dump`.
