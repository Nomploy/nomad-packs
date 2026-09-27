# streamystats

[Streamystats](https://github.com/fredrikburmester/streamystats) — a self-hosted **statistics and analytics dashboard**
for Jellyfin and Emby. See watch history, most-watched content, per-user activity, libraries and trends over time. This
pack uses the **all-in-one** image, which bundles PostgreSQL, the job server and the web app in one container.

Single host-networked Nomad service with one persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run streamystats --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port. |
| `db_password` | `change-me-…` | **Change this.** Bundled PostgreSQL password. |
| `session_secret` | `change-me-…` | **Change this.** Signs sessions. `openssl rand -hex 64`. |
| `image` | `ghcr.io/fredrikburmester/streamystats-aio:latest` | All-in-one image. Pin a tag in production. |
| `data_volume` | `streamystats_data` | `/var/lib/postgresql/data` — the bundled database (all stats). |
| `resources` | `{ cpu = 700, memory = 768 }` | Task resources. |

> On first launch, connect it to your [jellyfin](https://packs.nomploy.com/packs/jellyfin) server with an API key and let
> it sync. Because the bundled Postgres holds all data, pin the job to the node holding the volume with `constraints` and
> back it up. Pairs with [jellystat](https://packs.nomploy.com/packs/jellystat) / [tautulli](https://packs.nomploy.com/packs/tautulli).
