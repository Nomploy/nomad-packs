# Changelog

## 0.1.0

- Initial release: Grafana Loki (3.x, tsdb + schema v13, filesystem storage) as a
  host-networked Nomad service, with a prestart chown init so Loki (uid 10001) can write
  its named volume, a compactor enforcing configurable retention, and an optional Grafana
  Alloy sidecar that tails this node's Docker container logs (via the socket) and pushes
  them to Loki. Nomad service discovery on the Loki port.
