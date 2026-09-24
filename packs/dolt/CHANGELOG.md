# Changelog

## 0.1.0

- Initial release: Dolt (Git-for-data, MySQL-compatible versioned SQL database) as a host-networked
  Nomad service running `dolt sql-server` with a configurable port, root credentials via
  DOLT_ROOT_PASSWORD / DOLT_ROOT_HOST, a persistent /var/lib/dolt volume, and Nomad service discovery.
