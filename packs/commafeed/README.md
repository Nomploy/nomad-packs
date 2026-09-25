# commafeed

[CommaFeed](https://github.com/Athou/commafeed) — a fast, **Google Reader-style RSS/Atom feed reader**. Keyboard-driven,
with categories, tags, starred items, full-text scraping and mobile apps. This pack uses the embedded **H2** database,
so it runs as a single self-contained container — no external database to manage.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run commafeed --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8082` | Web UI port (`QUARKUS_HTTP_PORT`). |
| `image` | `athou/commafeed:latest-h2` | Container image (embedded H2). Pin a tag in production. |
| `data_volume` | `commafeed_data` | `/root/.local/share/commafeed` — the H2 database. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. The JVM needs some headroom. |

> The first account you create becomes the admin (self-registration can be disabled afterwards in settings). For a
> large multi-user instance, switch to the `latest-postgresql` image and point it at an external database. Pin the job
> to the node holding the volume with `constraints`.
