# Changelog

## 0.1.0

- Initial release: Cefiro (self-hosted social recipe platform, AGPL fork of Norish) as an all-in-one
  host-networked Nomad job — the app plus PostgreSQL 17, Redis, and the Obscura page-renderer as
  prestart sidecars, a prestart chown for the uploads volume, persistent DB/redis/uploads volumes,
  configurable ports, AUTH_URL/MASTER_KEY, and Nomad service discovery.
