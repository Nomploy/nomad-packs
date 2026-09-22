# Changelog

## 0.1.0

- Initial release: Docmost as an all-in-one, host-networked Nomad job with PostgreSQL and
  Redis as prestart sidecars and a prestart chown for the uploads volume. Persistent volumes
  for the database and attachments (Redis is ephemeral), configurable port/app URL/secret,
  and Nomad service discovery. Docmost migrates on start.
