# Changelog

## 0.1.0

- Initial release: Apache CouchDB as a host-networked Nomad service with a prestart chown so
  it (uid 5984) can write its persistent volume, a rendered config for the HTTP port/bind,
  bootstrap admin credentials, and Nomad service discovery.
