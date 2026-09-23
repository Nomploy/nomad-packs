# mealie

[Mealie](https://mealie.io) — a self-hosted recipe manager and meal planner. Import recipes from any
URL with the built-in scraper, organize them with tags and categories, build a meal-plan calendar,
generate shopping lists, and drive it all from a clean UI or the REST API.

Single host-networked Nomad service using **SQLite** with a persistent `/app/data` volume — no
external database needed (recommended for households and small teams).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run mealie --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9000` | Web UI / API port (`API_PORT`). |
| `base_url` | `""` → `http://localhost:<port>` | `BASE_URL` — set to your real domain. |
| `allow_signup` | `false` | Open self-registration (`ALLOW_SIGNUP`). Leave off; invite users instead. |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `data_volume` | `mealie_data` | `/app/data` — SQLite DB, recipe images, backups. |
| `image` | `ghcr.io/mealie-recipes/mealie:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

On first boot Mealie creates a default admin (`changeme@example.com` / `MyPassword`) — log in and
change it right away. Serves plain HTTP — front it with a reverse proxy for TLS. Pin the job to the
node holding the volume with `constraints`.
