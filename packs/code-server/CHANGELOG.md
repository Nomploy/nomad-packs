# Changelog

## 0.1.0

- Initial release: code-server (VS Code in the browser) as a host-networked Nomad service
  with a prestart chown so it (uid 1000) can write its persistent home volume, password
  auth via the PASSWORD env, a configurable bind port, and Nomad service discovery.
