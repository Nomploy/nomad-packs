# docuseal

[DocuSeal](https://www.docuseal.com) — an open-source document signing platform and a self-hosted
DocuSign alternative. Build fillable PDF forms with a drag-and-drop editor, send them for signature,
and collect legally-binding e-signatures, with a REST API, templates, and an audit trail.

Single host-networked Nomad service using **SQLite** with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run docuseal --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3026` | Web UI port (`PORT`). |
| `secret_key_base` | `change-me-…` | `SECRET_KEY_BASE` — signs sessions/cookies. **Change it** (`openssl rand -hex 64`). |
| `data_volume` | `docuseal_data` | `/data` — SQLite database and uploaded documents. |
| `image` | `docuseal/docuseal:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

On first run, open the UI to create the admin account. Uses SQLite by default; to switch to PostgreSQL,
add a `DATABASE_URL` env var to the task. To email signing requests, configure SMTP (`SMTP_ADDRESS`,
`SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD`). Serves plain HTTP — front it with a reverse proxy for TLS.
Pin the job to the node holding the volume with `constraints`.
