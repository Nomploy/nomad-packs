# Changelog

## 0.1.0

- Initial release: Rallly (self-hosted meeting scheduling / group polls) as an all-in-one
  host-networked Nomad job — a PostgreSQL prestart sidecar with a persistent data volume plus the
  Rallly app, configurable port and base URL, session-encryption secret, and Nomad service
  discovery. Migrations run automatically on boot.
