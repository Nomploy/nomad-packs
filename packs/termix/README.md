# termix

[Termix](https://github.com/LukeGus/Termix) is a self-hosted **SSH and remote-desktop
management hub** — a browser terminal, SSH tunnels, an RDP/VNC client, a server
inventory and session recording, all in one place.

This pack runs Termix **all-in-one** as a single host-networked Nomad job:

- **termix** — the app and web UI (`ghcr.io/lukegus/termix:latest`)
- **guacd** — the Apache Guacamole proxy daemon (prestart sidecar) that powers RDP/VNC
  sessions

Both share the host network (so termix reaches guacd over `127.0.0.1`) and the
`termix_data` volume (inventory, settings, session recordings, RDP drive). No external
database is required.

## Quick start

```sh
nomad-pack run termix --registry=nomploy
```

Then open `http://<node-ip>:8080` and create the first admin account.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `8080` | Web UI host port |
| `guacd_port` | `4822` | Bundled guacd daemon (loopback) |
| `data_volume` | `termix_data` | Shared data + recordings volume |

## Security

Termix stores the SSH/RDP/VNC credentials for the hosts you add, so treat it as
sensitive: keep it behind your VPN or a reverse proxy that enforces authentication, and
back up the `termix_data` volume regularly.
