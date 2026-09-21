# Changelog

## 0.1.0

- Initial release: NocoDB as an all-in-one, host-networked Nomad job with its PostgreSQL
  database as a prestart sidecar. Persistent volumes for the metadata DB and for uploads
  (/usr/app/data), configurable port/public URL/JWT secret, and Nomad service discovery.
  NocoDB migrates on start.
