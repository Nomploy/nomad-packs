# victoriametrics

[VictoriaMetrics](https://victoriametrics.com) — a fast, cost-efficient, open-source
**time-series database**. Prometheus-compatible: use it as a `remote_write` target for
long-term storage and query it with PromQL/MetricsQL (or its `/vmui`). A lighter, more
storage-efficient alternative/complement to Prometheus. Single host-networked Nomad service
with a persistent volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run victoriametrics --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `victoriametrics`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy. Query UI at
`http://<node-ip>:8428/vmui`.

## Pair with the monitoring pack

Send Prometheus data to it for long-term storage:

```yaml
remote_write:
  - url: http://127.0.0.1:8428/api/v1/write
```

Or add it directly to Grafana as a Prometheus-type datasource.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `victoriametrics/victoria-metrics:latest` | Pin a tag in production. |
| `port` | `8428` | HTTP API + `/vmui`. |
| `retention` | `3` | `-retentionPeriod`: number = months, or `30d` / `1y`. |
| `data_volume` | `victoriametrics_data` | Time-series storage. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise for high ingestion / long retention. |

## Notes

- **Single node.** `count` is fixed to 1 (local storage volume). Pin with `constraints`.
  (VictoriaMetrics also has a clustered edition — out of scope here.)
- VictoriaMetrics runs as root in the image, so a fresh volume is writable (no chown).
- No auth on the HTTP API — keep it internal or front it with an authenticating proxy.
