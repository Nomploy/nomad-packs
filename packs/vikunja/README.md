# vikunja

[Vikunja](https://vikunja.io) — an open-source, self-hosted **to-do and project management**
app: lists, kanban, table and gantt views, reminders, labels, and sharing. Deployed as a
single host-networked Nomad service using the **bundled SQLite** database (no external
dependency).

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run vikunja --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `vikunja`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:3456` and register the first account.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `vikunja/vikunja:latest` | Pin a tag in production. |
| `port` | `3456` | Web UI + API. |
| `public_url` | `""` | Set (with trailing slash) when behind a domain/proxy so the frontend can reach the API. |
| `service_secret` | `""` | JWT signing secret; set a stable value or sessions reset on restart. |
| `data_volume` | `vikunja_data` | SQLite DB + uploads. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 300 / mem 256` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 (SQLite on a local volume). A prestart task chowns
  the volume to uid 1000 (Vikunja's user). Pin with `constraints`.
- For direct `http://<node-ip>:3456` access you can leave `public_url` empty (same-origin).
  Behind a reverse proxy/domain, set it (and TLS at the proxy).
- For a bigger deployment, switch `VIKUNJA_DATABASE_TYPE` to postgres/mysql (extra env; not
  configured here).
