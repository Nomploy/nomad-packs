# loki

[Grafana Loki](https://grafana.com/oss/loki/) — log aggregation — deployed **all-in-one**:
Loki plus a **Grafana Alloy** shipper that tails this node's Docker container logs and
pushes them to Loki. Alloy is the modern replacement for Promtail (which reached
end-of-life in Feb 2026). Single host-networked Nomad job, filesystem storage on a
persistent volume. This is the logging half of the observability story — pair it with the
**monitoring** pack (metrics).

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run loki --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `loki`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

## Wire it into Grafana

Loki is a data source, not a UI. In Grafana (e.g. from the `monitoring` pack):

1. **Connections → Data sources → Add data source → Loki**
2. URL: `http://127.0.0.1:3100` (same node) or `http://<node-ip>:3100`
3. **Explore** → query `{job="docker"}` to see container logs, or
   `{container="<name>"}` for one container.

Every container's logs arrive labelled `job="docker"` and `container="<name>"`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `loki_image` | `grafana/loki:latest` | **Pin a 3.x tag** — Loki's config schema is version-sensitive. |
| `enable_alloy` | `true` | Bundled log shipper. False = Loki only; push from your own agents. |
| `loki_port` | `3100` | Loki HTTP API (push + query). |
| `alloy_port` | `12345` | Alloy UI/debug. |
| `retention` | `336h` | Retention as a Go duration in hours (168h=7d, 720h=30d); enforced by the compactor. |
| `loki_data_volume` | `loki_data` | Chunks + index. Back up. |
| `constraints` | `[]` | Pin to a node — Alloy tails that node's containers. |

Per-task resources: `loki_resources`, `alloy_resources`.

## Scope & notes

- **Single node.** `count` is fixed to 1 with a local volume, and the bundled Alloy only
  sees the node the alloc runs on. Pin it with `constraints`. To collect from every node,
  run Alloy per node (a future variant) all pointing at this Loki.
- **Storage:** filesystem on the local volume. For a bigger/HA setup, point Loki's
  storage at S3 (e.g. the `seaweedfs` pack) — a future config option.
- **Alloy** reads logs through the Docker socket (mounted read-only). It runs as root to
  access the socket.
- Loki's usage-analytics reporting is disabled in the rendered config.
