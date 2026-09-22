# Changelog

## 0.1.0

- Initial release: InfluxDB 2 as a host-networked Nomad service that runs first-boot setup
  (admin user, org, bucket, admin token) via DOCKER_INFLUXDB_INIT_*, with a configurable HTTP
  bind port, a persistent Docker volume, and Nomad service discovery.
