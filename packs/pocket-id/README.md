# pocket-id

[Pocket ID](https://pocket-id.org) — a simple, **passkey-first OpenID Connect (OIDC) provider**.
Sign in to your self-hosted apps with WebAuthn passkeys, no passwords. A lightweight alternative
to the [keycloak](../keycloak) / [authentik](../authentik) packs for SSO.

Single host-networked Nomad service on SQLite with a data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run pocket-id --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `1411` | Web UI / OIDC port (`PORT`). |
| `app_url` | `""` | **Public URL** (`APP_URL`) — required for passkeys; must match the browser origin exactly. |
| `trust_proxy` | `false` | Trust reverse-proxy headers (`TRUST_PROXY`). |
| `data_volume` | `pocket_id_data` | `/app/data` — SQLite database + keys. |
| `image` | `ghcr.io/pocket-id/pocket-id:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Passkeys need a secure context.** Set `app_url` to the exact URL your browser uses and serve
> over **HTTPS** (WebAuthn only allows `localhost` over HTTP). Behind a TLS proxy, set `app_url` to
> the `https://` URL and `trust_proxy = true`.

Open the URL to create the first admin + passkey, then register OIDC clients. Pin the job to the
node holding the volume with `constraints`.
