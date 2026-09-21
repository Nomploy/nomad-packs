# Changelog

## 0.1.0

- Initial release: Ghost as an all-in-one, host-networked Nomad job with its MySQL 8
  database as a prestart sidecar (Ghost 5 requires MySQL 8). Persistent volumes for the
  database and for /var/lib/ghost/content (with a prestart chown so Ghost can write it),
  configurable URL/port, and Nomad service discovery. Ghost migrates on start.
