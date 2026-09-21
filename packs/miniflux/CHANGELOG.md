# Changelog

## 0.1.0

- Initial release: Miniflux as an all-in-one, host-networked Nomad job with its PostgreSQL
  database as a prestart sidecar. Runs migrations and creates the admin user on first start
  (RUN_MIGRATIONS/CREATE_ADMIN), configurable port/base URL, persistent Postgres volume, and
  Nomad service discovery.
