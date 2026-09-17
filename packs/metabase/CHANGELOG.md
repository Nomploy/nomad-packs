# Changelog

## 0.1.0

- Initial release: Metabase as an all-in-one, host-networked Nomad job with its
  application PostgreSQL as a prestart sidecar (instead of the unsafe embedded H2).
  Persistent named volume for Postgres, configurable port, optional site URL and
  encryption key for stored credentials, and Nomad service discovery. Metabase migrates
  its app DB on start.
