# Changelog

## 0.1.0

- Initial release: cloudflared as a stateless host-networked Nomad service running a
  token-based Cloudflare Tunnel (`tunnel run`), with a configurable replica count for HA.
  Outbound-only; routing is managed in the Cloudflare dashboard.
