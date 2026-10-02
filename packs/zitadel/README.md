# zitadel

[ZITADEL](https://zitadel.com) is a modern, open-source identity and access
management platform — a self-hosted alternative to Auth0 or Keycloak. It provides
OIDC, OAuth2, SAML 2.0 and SCIM, multi-tenancy (organizations), passwordless and
MFA, self-service and a polished management console, with an event-sourced audit
trail.

This pack deploys ZITADEL **all-in-one** as a single host-networked Nomad job:
**PostgreSQL** (bundled as a prestart sidecar) plus the ZITADEL app. The database
is initialised and migrated automatically on first start (`start-from-init`).

## Deploy

```bash
nomad-pack run zitadel --registry=nomploy \
  --var external_domain=auth.example.com --var external_secure=true \
  --var masterkey=$(openssl rand -hex 16) \
  --var db_password=$(openssl rand -hex 16) \
  --var admin_password='S0me-Strong-Pass!'
```

Open `http://<node-ip>:8080/ui/console` and sign in as
`zitadel-admin@zitadel.<external_domain>`.

## Configuration

| Variable          | Default                        | Description                                      |
| ----------------- | ------------------------------ | ------------------------------------------------ |
| `image`           | `ghcr.io/zitadel/zitadel:latest`| App image (pin a tag in production).               |
| `postgres_image`  | `postgres:16-alpine`           | Bundled PostgreSQL image.                          |
| `port`            | `8080`                         | Host port for the console / API.                  |
| `db_password`     | `zitadel_change_me`            | PostgreSQL password — **change this**.             |
| `masterkey`       | placeholder (32 chars)         | Secrets-encryption key — **change & keep stable**. |
| `external_domain` | `localhost`                    | **Public host** ZITADEL is reached at.             |
| `external_secure` | `false`                        | `true` when served over HTTPS.                     |
| `admin_username`  | `zitadel-admin`                | First admin (login `<user>@zitadel.<domain>`).    |
| `admin_password`  | `Password1!`                   | First admin password — **change this**.            |
| `resources`       | 1000 MHz / 1024 MB             | App task resources.                               |

> **Important:** `external_domain`/`external_secure` are baked into issued tokens
> and OIDC discovery — set them to the real public address up front; changing them
> later breaks existing clients. `masterkey` must be exactly 32 characters and
> stay constant. PostgreSQL data persists in `db_data_volume`.
