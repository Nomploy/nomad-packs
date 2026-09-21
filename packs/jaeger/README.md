# jaeger

[Jaeger](https://www.jaegertracing.io) — open-source **distributed tracing**: collect and
visualize traces to see request flow and latency across your services (the third
observability pillar, alongside metrics and logs). This pack runs the **all-in-one** image
with **in-memory** storage — a stateless host-networked Nomad service, ideal for dev/small
setups.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run jaeger --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `jaeger`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

- **UI** — `http://<node-ip>:16686`
- **OTLP** — gRPC `:4317`, HTTP `:4318` — set your OpenTelemetry SDK/collector exporter to
  one of these.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `jaegertracing/all-in-one:latest` | Pin a tag in production. |
| `ui_port` | `16686` | Query UI. |
| `otlp_grpc_port` / `otlp_http_port` | `4317` / `4318` | OTLP receivers. |
| `constraints` | `[]` | Placement. |
| `resources` | `cpu 500 / mem 512` | In-memory traces use RAM; raise to keep more. |

## Notes

- **In-memory storage** — traces are lost on restart and bounded by memory. For persistence
  at scale, run the Jaeger components against Badger/Cassandra/Elasticsearch (out of scope
  for this all-in-one pack).
- **Stateless** — no volume.
- No auth on the UI/OTLP — keep it internal.
