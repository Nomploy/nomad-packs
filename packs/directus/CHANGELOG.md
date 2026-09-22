# Changelog

## 0.1.0

- Initial release: Directus as an all-in-one, host-networked Nomad job with its PostgreSQL
  database as a prestart sidecar and a prestart chown for the uploads volume. Persistent
  volumes for the database and uploads, bootstrap admin, configurable port/public URL, and
  Nomad service discovery. Directus bootstraps the schema on start.
