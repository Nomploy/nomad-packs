# Changelog

## 0.1.0

- Initial release: Vikunja (unified frontend+API) as a host-networked Nomad service with a
  prestart chown so it (uid 1000) can write its persistent volume, the bundled SQLite
  database, configurable port/public URL/JWT secret, and Nomad service discovery.
