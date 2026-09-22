# linkwarden

[Linkwarden](https://linkwarden.app) — a self-hosted bookmark manager that also **archives** a
full copy of each link (screenshot, PDF, readable text) so pages survive link rot. Organize with
collections, tags, and sharing.

All-in-one host-networked Nomad job: a **PostgreSQL** prestart sidecar plus the **Linkwarden**
app. Bookmarks live in Postgres; archived snapshots on their own volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run linkwarden --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3012` | Web UI port (`PORT`). |
| `db_port` | `5432` | Co-located PostgreSQL port. |
| `db_password` | `linkwarden` | Password for the Linkwarden Postgres user. |
| `base_url` | `""` | Public URL for `NEXTAUTH_URL`; empty = `http://localhost:<port>`. See note. |
| `nextauth_secret` | placeholder | `NEXTAUTH_SECRET` — set a long random value. |
| `data_volume` | `linkwarden_data` | `/data/data` — archived snapshots. |
| `db_data_volume` | `linkwarden_db_data` | PostgreSQL data — all bookmarks. |
| `resources` / `postgres_resources` | see defaults | Per-task resources. |

> Set `base_url` to this node's host/IP or your domain — Linkwarden uses it for `NEXTAUTH_URL`
> (login/OAuth callbacks). Link archiving runs a headless browser, so give the app task enough
> memory. Pin the job to the node holding the volumes with `constraints`.
