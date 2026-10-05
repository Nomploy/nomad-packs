# blocky

[Blocky](https://0xerr0r.github.io/blocky/) is a fast, lightweight **DNS proxy and
ad-blocker** for your local network — blocklists, allowlists, per-client rules, caching,
conditional forwarding and Prometheus metrics, all from a single small Go binary.

This pack runs Blocky as a single host-networked Nomad job with a seeded `config.yml`.
Point your router or devices at it for network-wide ad/tracker blocking.

## Quick start

```sh
nomad-pack run blocky --registry=nomploy
```

Then set your network's DNS server to `<node-ip>` (port 53). The HTTP API, query UI and
Prometheus metrics are on port 4000.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `dns_port` | `53` | DNS port (UDP + TCP) |
| `http_port` | `4000` | HTTP API / metrics / query UI |
| `upstreams` | Quad9 + Cloudflare (DoH) | Upstream resolvers for the default group |
| `blocklists` | StevenBlack hosts | Denylist URLs applied to all clients |

Edit `upstreams` / `blocklists` and redeploy to change them. For advanced setups
(allowlists, per-client groups, conditional forwarding, custom DNS records) edit the
rendered config per the [Blocky docs](https://0xerr0r.github.io/blocky/).

The service is stateless apart from its blocklist cache; there is no database or volume.
