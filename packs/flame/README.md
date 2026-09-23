# flame

[Flame](https://github.com/pawelmalak/flame) — a self-hosted startpage / application dashboard you
manage entirely from the browser: add apps and bookmarks, group them, pin favourites, and see live
weather. Unlike config-file dashboards, everything is edited in the UI.

Single host-networked Nomad service on SQLite with a data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run flame --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5005` | Dashboard port (`PORT`). |
| `password` | `changeme-please` | Password for edit/admin mode (`PASSWORD`). **Change it.** |
| `data_volume` | `flame_data` | `/app/data` — SQLite database + uploads. |
| `image` | `pawelmalak/flame:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

Viewing is public; adding/editing requires the password. See also the config-file dashboards
[homepage](../homepage) and [glance](../glance). Pin the job to the node holding the volume with
`constraints`.
