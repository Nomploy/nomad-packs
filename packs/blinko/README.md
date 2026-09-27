# blinko

[Blinko](https://blinko.space/) — a self-hosted, privacy-first **note-taking** app for quickly capturing thoughts. Jot
notes in Markdown, organize with tags, search full-text, and optionally use AI to summarize and retrieve — with mobile
apps and a browser extension. This pack is **batteries-included** with a bundled PostgreSQL.

Single host-networked group: `blinko` + `postgres`.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run blinko --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `1111` | Web UI port. |
| `db_password` | `change-me-…` | **Change this.** Bundled PostgreSQL password. |
| `image` | `blinkospace/blinko:latest` | App image. Pin a tag in production. |
| `postgres_image` | `postgres:16` | Bundled database image. |
| `data_volume` | `blinko_data` | `/app/.blinko` — uploaded files. |
| `db_data_volume` | `blinko_db` | PostgreSQL data — your notes. |
| `db_port` | `5432` | Loopback PostgreSQL port. |
| `resources` / `db_resources` | … | Per-task resources. |

> Blinko runs database migrations automatically on start; the first account you create becomes the admin. Enable AI
> features later with your own OpenAI-compatible endpoint (e.g. [ollama](https://packs.nomploy.com/packs/ollama)) in
> settings. Because Postgres holds your notes, pin the job to the node holding the volumes with `constraints` and back it
> up.
