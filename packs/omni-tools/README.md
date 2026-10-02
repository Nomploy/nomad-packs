# omni-tools

[OmniTools](https://omnitools.app) is a self-hosted collection of **web-based everyday
tools** — image, PDF, text, number, date/time, list and data utilities — that run
entirely in your browser. No data is uploaded to a server, so it's a private alternative
to the many "online tools" sites.

This pack runs OmniTools as a single host-networked Nomad job: the static SPA served by
nginx. nginx is reconfigured (via a mounted server block) to listen on the chosen host
port instead of 80, so it won't collide with a reverse proxy.

## Quick start

```sh
nomad-pack run omni-tools --registry=nomploy
```

Then open `http://<node-ip>:8080`.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `8080` | Web UI host port |
| `count` | `1` | Instances to run (the app is stateless) |

The app is stateless — there is no database and nothing to persist. Scale it by raising
`count`.
