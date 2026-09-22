# Changelog

## 0.1.0

- Initial release: Actual Budget server as a host-networked Nomad service with a prestart
  chown so it (uid 1000) can write its persistent volume, a configurable port (ACTUAL_PORT),
  and Nomad service discovery.
