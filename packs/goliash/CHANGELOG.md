# Changelog

## 0.9.0

- Add `metrics_port`: when > 0, tag the service `nomploy.metrics.port=<port>` so nomploy's built-in
  OpenTelemetry Collector discovers and scrapes Goliash's Prometheus `/metrics`. Goliash serves metrics on the
  same port as the UI/API, so set it equal to `port` (e.g. 8070). If the endpoint needs auth, set the scrape
  credential in nomploy → Settings → Web Server → Observability.

## 0.8.0

- Browser push notifications: always set `GOLIASH_PUSH_SUBJECT` (new `push_subject` variable, default
  `mailto:<owner_email>`) so push works out of the box — an https `public_url` alone is not enough. Added
  push-setup notes (https origin, install as a PWA on iPhone, needs an alert rule with events).

## 0.1.0

- Initial pack: Goliash server with SQLite on a volume, bootstrapped owner and environment, and the Nomad cluster
  it runs on watched out of the box.
