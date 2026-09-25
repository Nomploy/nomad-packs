# openobserve

[OpenObserve](https://openobserve.ai/) — a **single-binary observability platform** for logs, metrics and traces,
with a built-in web UI, dashboards, alerts and a SQL/query language. It's OpenTelemetry-native and Elasticsearch
API-compatible, so you can point existing agents (OTel Collector, Fluent Bit, Vector, Promtail) at it. A lightweight,
storage-efficient alternative to an ELK stack or Datadog.

Single host-networked Nomad service with a persistent data volume (local disk store; S3 can be configured later).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run openobserve --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5080` | Web UI / ingestion port (`ZO_HTTP_PORT`). |
| `root_user_email` | `root@example.com` | Initial admin email (`ZO_ROOT_USER_EMAIL`). |
| `root_user_password` | `change-me-…` | **Change this.** Initial admin password (`ZO_ROOT_USER_PASSWORD`). |
| `image` | `public.ecr.aws/zinclabs/openobserve:latest` | Container image. Pin a tag in production. |
| `data_volume` | `openobserve_data` | `/data` — metadata and the local object store. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Bump for heavy ingestion. |

> Log in with the root email/password, then create ingestion tokens under **Data Sources**. To offload storage to
> S3/MinIO, add the `ZO_S3_*` env vars to the task. Pin the job to the node holding the volume with `constraints`.
