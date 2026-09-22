# statping

[Statping-ng](https://github.com/statping-ng/statping-ng) — a status page for monitoring your
websites and services, with uptime history, response-time graphs, incident tracking, and
notifications (a maintained drop-in for the original Statping).

Single host-networked Nomad service on SQLite with a persistent data volume. See also the
[uptime-kuma](../uptime-kuma) and [gatus](../gatus) packs.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run statping --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8104` | Web UI port (`PORT`). |
| `admin_user` / `admin_password` | `admin` / `changeme-please` | Initial admin. **Change the password.** |
| `data_volume` | `statping_data` | `/app` — config, SQLite database, assets. |
| `image` | `adamboutcher/statping-ng:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Add the services you want to monitor from the dashboard. Pin the job to the node holding the
volume with `constraints`.
