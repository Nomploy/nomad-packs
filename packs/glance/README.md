# glance

[Glance](https://github.com/glanceapp/glance) — a self-hosted **dashboard** that puts your
RSS feeds, weather, markets, calendar, server/Docker stats, and service widgets on a single
fast, config-driven page. A lighter, widget-focused alternative to the `homepage` pack.
Stateless host-networked Nomad service; the dashboard is defined by config.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run glance --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `glance`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy. Open `http://<node-ip>:3009`.

## Configuring the dashboard

Set the `pages` variable to the `pages:` section of a Glance config, e.g.:

```yaml
- name: Home
  columns:
    - size: full
      widgets:
        - type: clock
        - type: rss
          feeds:
            - url: https://hnrss.org/frontpage
```

See the [Glance configuration docs](https://github.com/glanceapp/glance/blob/main/docs/configuration.md)
for all widgets (weather, markets, monitor, docker, custom-api, …).

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `glanceapp/glance:latest` | Pin a tag in production. |
| `port` | `3009` | Dashboard host port. |
| `pages` | a Home page (clock + search) | Replace with your own pages/widgets. |
| `constraints` | `[]` | Placement. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- **Stateless** — no volume; the config comes from the `pages` variable. Change it and
  redeploy. (Some widgets fetch from the node, so pin with `constraints` if a widget needs a
  specific network.)
