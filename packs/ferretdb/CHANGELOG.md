# Changelog

## 0.1.0

- Initial release: FerretDB v2 as an all-in-one, host-networked Nomad job with its required
  DocumentDB-enabled PostgreSQL as a prestart sidecar. Persistent volume for Postgres,
  configurable MongoDB/Postgres ports and credentials, and Nomad service discovery. FerretDB
  itself is stateless (all data lives in Postgres).
