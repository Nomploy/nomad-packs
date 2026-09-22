# mysqld-exporter

[Prometheus MySQLd Exporter](https://github.com/prometheus/mysqld_exporter) — scrapes a MySQL or
MariaDB server and exposes connection, query, InnoDB, and replication metrics for Prometheus.

Stateless, host-networked Nomad service. Point it at any reachable server; with host networking
a co-located [mariadb](../mariadb) pack is on `127.0.0.1:3306`.

> Uses the mysqld_exporter v0.15+ interface (`--mysqld.address` / `--mysqld.username` +
> `MYSQLD_EXPORTER_PASSWORD`), which replaced the old `DATA_SOURCE_NAME` env var.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run mysqld-exporter --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9104` | Host port for `/metrics`. |
| `mysql_address` | `127.0.0.1:3306` | Target `host:port` (`--mysqld.address`). |
| `mysql_user` | `exporter` | Exporter user (`--mysqld.username`). |
| `mysql_password` | `exporter` | Exporter password (`MYSQLD_EXPORTER_PASSWORD`). Change it. |
| `image` | `prom/mysqld-exporter:latest` | Exporter image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 64 }` | Task resources. |

Create a least-privilege monitoring user first:

```sql
CREATE USER 'exporter'@'%' IDENTIFIED BY '...' WITH MAX_USER_CONNECTIONS 3;
GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';
```

## Scrape

```yaml
- job_name: mysql
  static_configs:
    - targets: ['127.0.0.1:9104']
```
