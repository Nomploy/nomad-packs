# victoria-logs

[VictoriaLogs](https://docs.victoriametrics.com/victorialogs/) — a fast, resource-efficient
open-source **log database** from the VictoriaMetrics team, with its own **LogsQL** query
language and a built-in UI. A lighter alternative to the `loki` pack / Elasticsearch. Single
host-networked Nomad service with a persistent volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run victoria-logs --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `victoria-logs`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy. UI at
`http://<node-ip>:9428/select/vmui`.

## Shipping logs

VictoriaLogs accepts several ingestion formats — Loki push, Elasticsearch bulk,
OpenTelemetry, journald, syslog — so point a shipper (Grafana Alloy, Fluent Bit, Vector, …)
at it. It can also be added to Grafana via the VictoriaLogs datasource.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `victoriametrics/victoria-logs:latest` | Pin a tag in production. |
| `port` | `9428` | HTTP API + UI. |
| `retention` | `30d` | `-retentionPeriod` (e.g. `7d`, `1y`). |
| `data_volume` | `victoria_logs_data` | Log storage. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise for high ingestion / long retention. |

## Notes

- **Single node.** `count` is fixed to 1 (local storage volume). Pin with `constraints`.
- Runs as root in the image, so a fresh volume is writable (no chown).
- No auth on the API — keep it internal or front it with an authenticating proxy.
- vs `loki`: both are log stores; VictoriaLogs is a single lightweight binary with LogsQL,
  Loki uses LogQL and integrates tightly with Grafana. Pick whichever fits.
