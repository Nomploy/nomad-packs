# tinyauth

[Tinyauth](https://tinyauth.app) is the simplest way to add authentication to
any application. It runs as a lightweight **forward-auth** middleware behind
your reverse proxy (Traefik, Caddy, Nginx, Traefik Kubernetes…): unauthenticated
requests get a clean login screen, and once signed in the request is passed
through. It supports simple username/password, OAuth (Google, GitHub, generic
OIDC), LDAP and TOTP.

This pack runs Tinyauth as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run tinyauth --registry=nomploy \
  --var app_url=https://auth.example.com \
  --var secret=$(openssl rand -hex 16) \
  --var users="admin:$(htpasswd -bnBC 10 '' 'yourpassword' | tr -d ':\n' | sed 's/^/admin:/')"
```

Then point your proxy's forward-auth at `http://<node-ip>:3000/api/auth/traefik`
(or the Nginx/Caddy equivalent) for the apps you want to protect.

## Configuration

| Variable  | Default                            | Description                                          |
| --------- | ---------------------------------- | ---------------------------------------------------- |
| `image`   | `ghcr.io/tinyauthapp/tinyauth:v5`  | Container image (pin a tag in production).              |
| `port`    | `3000`                             | Host port for the Tinyauth server.                    |
| `app_url` | `http://localhost:3000`            | **Public URL** Tinyauth is served from.               |
| `secret`  | placeholder (32 chars)             | Session-signing secret (**exactly 32 chars**).        |
| `users`   | `user:<bcrypt>` (password `password`) | Login users as `username:bcrypthash` — **change this**. |
| `resources`| 200 MHz / 128 MB                  | CPU and memory for the task.                           |

> **Security:** `secret` must be exactly 32 characters and the default user must
> be replaced. Generate a user with `docker run ghcr.io/tinyauthapp/tinyauth:v5
> user create` (bcrypt), and set OAuth/LDAP via the additional `TINYAUTH_*` env
> vars from the docs.
