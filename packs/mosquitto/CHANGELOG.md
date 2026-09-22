# Changelog

## 0.1.0

- Initial release: Eclipse Mosquitto as a host-networked Nomad service with a rendered
  mosquitto.conf (configurable listener port + anonymous access), a persistent volume for
  message persistence (with a prestart chown to uid 1883), and Nomad service discovery.
