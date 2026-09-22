# influxdb

[InfluxDB 2](https://www.influxdata.com) — a purpose-built **time-series database** with a
built-in UI, dashboards, tasks, and the Flux/InfluxQL query languages. Ideal for metrics and
IoT sensor data. Host-networked Nomad service that initializes itself on first boot, with a
persistent volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs \
  --var admin_password=<8+ chars> --var admin_token=<secret>
nomad-pack run influxdb --registry nomploy --var admin_password=<8+ chars> --var admin_token=<secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `influxdb`, set
`admin_password` + `admin_token`, then Deploy. Open `http://<node-ip>:8086`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `influxdb:2` | Pin a tag in production. |
| `port` | `8086` | HTTP API + UI. |
| `admin_user` / `admin_password` | `admin` / `changeme123` | First-boot admin (password ≥ 8 chars). **Change it.** |
| `org` / `bucket` | `nomploy` / `default` | Initial org + bucket. |
| `admin_token` | `changeme-admin-token` | API token clients use. **Change it.** |
| `data_volume` | `influxdb_data` | Time-series data + config. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise for high ingestion. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). Pin with `constraints`.
- Setup (`DOCKER_INFLUXDB_INIT_MODE=setup`) runs only on an **empty** volume — the admin/org/
  bucket/token are created once.
- vs `victoriametrics`: InfluxDB has a full UI/dashboards and Flux; VictoriaMetrics is a
  leaner Prometheus-compatible store. Pick whichever fits.
