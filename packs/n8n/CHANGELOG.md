# Changelog

## 0.1.0

- Initial release: n8n as a host-networked Nomad service with a prestart chown so n8n
  (uid 1000) can write its persistent named volume, the bundled SQLite database for a
  zero-dependency setup, configurable port/host/webhook URL/timezone, an optional
  encryption key (auto-generated and persisted when unset), a secure-cookie toggle for
  plain-HTTP access, and Nomad service discovery.
