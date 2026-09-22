# blackbox-exporter

[Prometheus Blackbox Exporter](https://github.com/prometheus/blackbox_exporter) — probes
endpoints over **HTTP(S), TCP, DNS, and ICMP** and exposes the results for Prometheus to
scrape: uptime, response time, status codes, and TLS cert expiry. Stateless host-networked
Nomad service; pairs with the `monitoring` pack (and alert via `alertmanager`).

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run blackbox-exporter --registry nomploy
```

Then have Prometheus scrape your targets *through* it (see the deploy output for the
`relabel_configs` snippet). Probe directly to test:

```sh
curl "http://<node-ip>:9115/probe?target=https://example.com&module=http_2xx"
```

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `prom/blackbox-exporter:latest` | Pin a tag in production. |
| `port` | `9115` | `/probe` + `/metrics`. |
| `config` | http_2xx / tcp_connect / icmp | Full `blackbox.yml` modules — extend as needed. |
| `constraints` | `[]` | Probes run from the node it lands on — pin accordingly. |
| `resources` | `cpu 200 / mem 64` | Tiny. |

## Notes

- **Stateless** — no volume; config comes from the `config` variable.
- ICMP probes may require extra Linux capabilities on some hosts; HTTP/TCP work out of the box.
- Probes originate from the node running the exporter — pin it where it can reach your targets.
