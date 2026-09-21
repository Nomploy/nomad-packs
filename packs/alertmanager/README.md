# alertmanager

[Prometheus Alertmanager](https://prometheus.io/docs/alerting/latest/alertmanager/) —
receives alerts from Prometheus and deduplicates, groups, silences, and routes them to
receivers (email, Slack, PagerDuty, or a webhook to the `ntfy`/`gotify` packs). Pairs with
the `monitoring` pack. Host-networked Nomad service with a persistent volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run alertmanager --registry nomploy
```

Then point Prometheus at it — in the `monitoring` pack's config:

```yaml
alerting:
  alertmanagers:
    - static_configs:
        - targets: ['127.0.0.1:9093']
```

Open `http://<node-ip>:9093` for the UI.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `prom/alertmanager:latest` | Pin a tag in production. |
| `port` | `9093` | UI / API. |
| `config` | minimal no-op | **Replace it** with your real `alertmanager.yml` (routes + receivers). |
| `data_volume` | `alertmanager_data` | Silences + notification log. |
| `constraints` | `[]` | Placement. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- The default `config` is a valid but no-op setup (alerts go to a receiver that does
  nothing) so it starts cleanly. Set `config` to real receivers to actually get notified —
  e.g. a `webhook_configs` pointing at the `ntfy`/`gotify` packs.
- **Single node.** `count` is fixed to 1. For an Alertmanager cluster (gossip/HA) you'd run
  multiple with `--cluster.*` peers — out of scope here.
