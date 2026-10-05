# sun-panel

[Sun-Panel](https://doc.sun-panel.top) is a server / NAS **navigation panel and homepage** —
a browser start page with app bookmarks, rich icons (Iconify), a system-status widget,
multiple accounts and custom CSS/JS.

This pack runs Sun-Panel as a single host-networked Nomad job. Its config, SQLite database
and uploads live in the `sun_panel_conf` volume (`/app/conf`) — no external database is
required.

## Quick start

```sh
nomad-pack run sun-panel --registry=nomploy
```

Then open `http://<node-ip>:3002` and sign in with the default account:

- **username:** `admin@sun.cc`
- **password:** `12345678`

Change the password immediately.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `3002` | Web UI host port |
| `conf_volume` | `sun_panel_conf` | Config + SQLite database + uploads |

The server listens on 3002 inside the container; if you change `port`, also update
`http_port` in `/app/conf/conf.ini`. Data persists in the `sun_panel_conf` named volume.
