# postgres-exporter

[Prometheus Postgres Exporter](https://github.com/prometheus-community/postgres_exporter) —
scrapes a PostgreSQL server and exposes database, table, index, and replication metrics for
Prometheus.

Stateless, host-networked Nomad service. Point it at any reachable Postgres with a DSN; with
host networking a co-located [postgres](../postgres) pack is on `127.0.0.1`.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run postgres-exporter --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9187` | Host port for `/metrics`. |
| `data_source_name` | `postgresql://postgres:postgres@127.0.0.1:5432/postgres?sslmode=disable` | Postgres DSN (`DATA_SOURCE_NAME`). |
| `image` | `quay.io/prometheuscommunity/postgres-exporter:latest` | Exporter image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 64 }` | Task resources. |

Use a read-only monitoring role rather than a superuser:

```sql
CREATE USER pg_exporter WITH PASSWORD '...';
GRANT pg_monitor TO pg_exporter;
```

Then set `data_source_name = "postgresql://pg_exporter:...@127.0.0.1:5432/postgres?sslmode=disable"`.

## Scrape

```yaml
- job_name: postgres
  static_configs:
    - targets: ['127.0.0.1:9187']
```
