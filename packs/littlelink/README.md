# littlelink

[LittleLink Server](https://github.com/techno-tim/littlelink-server) — a lightweight, self-hosted
**link-in-bio** page and a Linktree alternative. One clean page with your bio and social/link buttons,
configured entirely through environment variables — **stateless**, no database.

Single host-networked Nomad service; raise `count` to run several.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run littlelink --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Page port. The container listens on 3000. |
| `name` | `Your Name` | Display name / title (`NAME`). |
| `theme` | `auto` | `THEME`: `auto`, `light`, or `dark`. |
| `description` | `My links` | Short bio (`DESCRIPTION`). |
| `avatar_url` | `""` | Avatar image URL (`AVATAR_URL`); empty = default. |
| `count` | `1` | Instances to run (stateless — safe to scale). |
| `image` | `timothystewart6/littlelink-server:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

The page is fully driven by env vars. Add social handles and custom buttons — `TWITTER`, `GITHUB`,
`EMAIL`, `BUTTON_1_URL`/`BUTTON_1_TEXT`, etc. — per the LittleLink Server docs. To change the port, keep
`port` in sync with `PORT` (already wired). Serves plain HTTP — front it with a reverse proxy for TLS.
