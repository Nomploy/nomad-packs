# baserow

[Baserow](https://baserow.io/) — a no-code **database and spreadsheet** platform, an open-source Airtable
alternative. Build tables with rich field types, link records, create grid/gallery/kanban/form views, collaborate in
real time, and automate with the REST API and webhooks.

This pack uses the **all-in-one** image, which bundles PostgreSQL, Redis and a Caddy reverse proxy in one container,
so it runs as a single host-networked Nomad service with one persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run baserow --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3001` | Web UI port. Baserow's bundled Caddy listens here (`BASEROW_CADDY_ADDRESSES`). |
| `base_url` | `""` | **Set for real use.** Public URL (`BASEROW_PUBLIC_URL`) — must match what users open, including the port. Empty = `http://localhost:<port>`. |
| `image` | `baserow/baserow:latest` | Container image. Pin a tag in production. |
| `data_volume` | `baserow_data` | `/baserow/data` — the embedded PostgreSQL, Redis state and uploaded files. |
| `resources` | `{ cpu = 1500, memory = 2048 }` | Task resources. The all-in-one image runs several services — give it room. |

> **`base_url` matters:** if `BASEROW_PUBLIC_URL` doesn't match the address you actually open (host + port), logins and
> API calls fail. The first account you create becomes an admin. Because Postgres/Redis live in the data volume, pin
> the job to the node holding it with `constraints`.
