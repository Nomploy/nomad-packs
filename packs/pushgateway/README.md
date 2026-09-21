# pushgateway

[Prometheus Pushgateway](https://github.com/prometheus/pushgateway) — an intermediary that
lets **short-lived and batch jobs push metrics** (which Prometheus can't scrape directly
because they don't run long enough). Prometheus then scrapes the Pushgateway. Stateless
host-networked Nomad service; pairs with the `monitoring` pack.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run pushgateway --registry nomploy
```

Push from a job, then scrape it:

```sh
echo "some_metric 42" | curl --data-binary @- http://<node-ip>:9091/metrics/job/my_batch
```

```yaml
# in the monitoring pack's prometheus.yml
- job_name: pushgateway
  honor_labels: true
  static_configs:
    - targets: ['127.0.0.1:9091']
```

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `prom/pushgateway:latest` | Pin a tag in production. |
| `port` | `9091` | Push API + `/metrics`. |
| `constraints` | `[]` | Placement. |
| `resources` | `cpu 100 / mem 64` | Tiny. |

## Notes

- **Stateless** — metrics are held in memory (add `--persistence.file` + a volume if you
  need them to survive a restart; not configured here).
- Use it only for service-level batch jobs, per Prometheus's guidance — it's not a general
  push replacement for scraping.
- Set `honor_labels: true` on the scrape so pushed `job`/`instance` labels win.
