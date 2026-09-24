# Changelog

## 0.1.0

- Initial release: Shlink (self-hosted URL shortener with analytics) as an all-in-one host-networked Nomad
  job — a PostgreSQL prestart sidecar with a persistent data volume plus the Shlink app, configurable
  default domain / HTTPS flag / initial API key, and Nomad service discovery. Migrations run on boot.
