# Changelog

## 0.1.0

- Initial release: authentik as an all-in-one, host-networked Nomad job — PostgreSQL + Redis
  as prestart sidecars plus the authentik server and worker. Persistent Postgres volume,
  configurable port, optional bootstrap admin, and Nomad service discovery. The server runs
  DB migrations on start.
