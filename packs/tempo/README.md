# tempo

[Grafana Tempo](https://grafana.com/oss/tempo/) — a high-scale, cost-efficient **distributed tracing** backend. It
ingests spans over OTLP and stores trace blocks on local disk (or object storage), and you explore traces from Grafana.
Together with Loki (logs), Prometheus (metrics) and Pyroscope (profiles) it completes the Grafana observability stack.

Single host-networked Nomad service. This pack renders a minimal single-binary config and stores data on a volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run tempo --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3200` | HTTP API / query port (`server.http_listen_port`). |
| `otlp_grpc_port` | `4317` | OTLP gRPC ingest port. |
| `otlp_http_port` | `4318` | OTLP HTTP ingest port. |
| `block_retention` | `336h` | How long to keep trace blocks (14 days). |
| `image` | `grafana/tempo:latest` | Container image. Pin a tag in production. |
| `data_volume` | `tempo_data` | `/var/tempo` — WAL and trace blocks. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Bump for heavy ingestion. |

> Send spans from your apps or an OTel Collector to `<host>:4317` (gRPC) or `<host>:4318` (HTTP). Add Tempo as a data
> source in [grafana](https://packs.nomploy.com/packs/grafana) (URL `http://<host>:3200`) to explore traces. A prestart
> init task chowns the data volume to uid `10001`. The bundled config uses local block storage; point it at
> [rustfs](https://packs.nomploy.com/packs/rustfs)/S3 for larger deployments. Pin the job with `constraints`.
