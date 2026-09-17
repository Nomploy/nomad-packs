# Changelog

## 0.1.0

- Initial release: NATS server as a host-networked Nomad service with JetStream enabled
  and persisted to a Docker named volume (/data), the HTTP monitoring endpoint on,
  configurable client/monitoring ports, an optional connection token, and Nomad service
  discovery. JetStream can be toggled off for core NATS only.
