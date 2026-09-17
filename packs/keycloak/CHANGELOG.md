# Changelog

## 0.1.0

- Initial release: Keycloak (26.x) as an all-in-one, host-networked Nomad job with its
  PostgreSQL database as a prestart sidecar. Persistent named volume for Postgres,
  bootstrap admin via KC_BOOTSTRAP_ADMIN_*, HTTP listener configured for reverse-proxy
  fronting (proxy headers on, hostname-strict off by default), and Nomad service
  discovery. Keycloak builds and migrates on start.
