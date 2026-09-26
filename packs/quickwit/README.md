# quickwit

[Quickwit](https://quickwit.io/) — a fast, cloud-native **search engine for logs, traces and analytics**. It delivers
sub-second full-text search with a small footprint, is OTEL-native (ingest logs and traces directly), and can store
indexes on local disk or object storage. A lightweight alternative to an Elasticsearch cluster for observability data.

Single host-networked Nomad service with a persistent index volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run quickwit --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `7280` | REST API / web UI port (`QW_REST_LISTEN_PORT`). |
| `image` | `quickwit/quickwit:latest` | Container image. Pin a tag in production. |
| `data_volume` | `quickwit_data` | `/quickwit/qwdata` — indexes and metadata. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Bump for heavy ingestion/search. |

> Open the UI at `http://<host>:7280`, then create indexes and push data via the REST API or the OTLP endpoints. A
> prestart init task makes the data volume writable. To scale storage, point Quickwit at S3/[rustfs](https://packs.nomploy.com/packs/rustfs)
> and back the metastore with [postgres](https://packs.nomploy.com/packs/postgres). Pin the job to the node holding the
> volume with `constraints`.
