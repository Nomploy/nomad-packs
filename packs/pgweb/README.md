# pgweb

[pgweb](https://sosedoff.github.io/pgweb/) — a fast, lightweight, browser-based PostgreSQL
client: browse tables, run queries, inspect schemas, and export results.

Stateless host-networked Nomad service in **sessions mode**, so each user enters their own
connection in the UI. Pairs with the [postgres](../postgres) pack.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run pgweb --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8081` | Web UI port. |
| `image` | `sosedoff/pgweb:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

Open the UI and connect to any reachable Postgres (a co-located postgres pack is on
`127.0.0.1:5432`). pgweb grants full database access — keep it internal or behind auth.
