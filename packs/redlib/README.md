# redlib

[Redlib](https://github.com/redlib-org/redlib) — a private, lightweight, **ad-free front-end for Reddit**. Browse posts
and comments with no JavaScript, no tracking and no account, on a fast, clean UI. A maintained successor to Libreddit.

Single **stateless** host-networked Nomad service (no volume; per-user preferences are stored in the browser).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run redlib --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI port. |
| `image` | `quay.io/redlib/redlib:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Set instance-wide defaults with `REDLIB_*` env vars (e.g. `REDLIB_DEFAULT_THEME`, `REDLIB_DEFAULT_SHOW_NSFW`) by
> adding them to the task. Being stateless, it needs no storage and scales horizontally — put it behind a reverse
> proxy over TLS for public use. Note Reddit periodically rate-limits public instances.
