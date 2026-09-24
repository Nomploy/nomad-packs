# manticore

[Manticore Search](https://manticoresearch.com) — a fast, open-source search engine. Full-text search,
filtering, faceting, autocomplete/suggestions, and vector search, exposed through a **MySQL-compatible SQL**
interface and an **HTTP/JSON** API. A lean Elasticsearch alternative that's easy to run and query.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run manticore --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `sql_port` | `9306` | MySQL-compatible SQL port. |
| `http_port` | `9308` | HTTP/JSON API port. |
| `binary_port` | `9312` | Binary protocol (inter-node/replication). |
| `data_volume` | `manticore_data` | `/var/lib/manticore` — all tables and indexes. |
| `image` | `manticoresearch/manticore:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. Bump memory for large indexes. |

Connect with any MySQL client (`mysql -h <node-ip> -P 9306`) or the JSON API on `9308`. The `EXTRA=1` env
enables the auto-schema/buddy helpers for a smooth quick start. Ports are **unauthenticated** — keep them on
an internal network. Pin the job to the node holding the volume with `constraints`.
