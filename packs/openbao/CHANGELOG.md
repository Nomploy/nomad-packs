# Changelog

## 0.1.0

- Initial release: OpenBao as a host-networked Nomad service with file storage on a
  persistent volume (prestart chown so the openbao user can write it), a rendered config
  (HTTP listener, mlock disabled so no IPC_LOCK capability is needed, UI on), and Nomad
  service discovery. Requires a one-time `operator init` + `unseal` after first deploy.
