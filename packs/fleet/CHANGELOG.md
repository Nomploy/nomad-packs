# Changelog

## 0.1.0

- Initial release: Fleet device management as an all-in-one, host-networked Nomad
  job — the Fleet server plus its required MySQL 8 and Redis dependencies in a
  single group. MySQL/Redis run as prestart sidecars; Fleet waits for the DB,
  runs `fleet prepare db` migrations, then serves. Persistent named volumes for
  MySQL and Redis, configurable ports/credentials/resources, optional server
  private key for MDM, and Nomad service discovery.
