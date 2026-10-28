# osctrl

[osctrl](https://osctrl.net) is a fast and efficient
[osquery](https://osquery.io) fleet management solution: a TLS endpoint osquery
agents enroll and report to, a REST API, and a React admin UI to manage
environments, nodes, queries, and logs.

This pack runs the whole stack in **one host-networked Nomad job**:

- `osctrl-tls` — the osquery TLS endpoint (agents connect here)
- `osctrl-api` — the REST/JWT API the admin UI calls
- `osctrl-frontend` — nginx serving the React SPA and proxying `/api` to the API
- `postgres` — bundled PostgreSQL (prestart sidecar, persistent named volume)
- `redis` — bundled Redis (prestart sidecar, ephemeral cache)
- `init` — `osctrl-cli` that creates the environment + admin user on first boot

The services share the host loopback, so they reach each other on `127.0.0.1`.

## Run

```sh
nomad-pack run osctrl --registry nomploy
```

Then open the admin UI on `http://<node-ip>:9001` and log in with the seeded
admin (`admin` / `Changeme123!` by default — change it).

## Key variables

| Variable | Default | Notes |
| --- | --- | --- |
| `frontend_port` | `9001` | Admin UI host port (front with TLS). |
| `tls_port` | `9000` | osquery TLS endpoint host port (front with TLS). |
| `api_port` | `9002` | API host port (proxied by the UI at `/api`). |
| `db_password` | `osctrl` | **Change this.** |
| `jwt_secret` | placeholder | **Change this** to a 64-char random value. |
| `admin_user` / `admin_password` | `admin` / `Changeme123!` | **Change the password.** |
| `env_name` | `prod` | osctrl environment osquery nodes enroll into. |
| `osquery_host` | `osctrl.example.com` | Public hostname agents use for the TLS endpoint. |
| `db_data_volume` | `osctrl_db_data` | PostgreSQL volume — **the critical state**. |
| `constraints` | `[]` | Pin placement (see below). |

See `variables.hcl` for the full list (images, ports, per-task resources).

## TLS and osquery enrollment

The osctrl binaries serve **plain HTTP**; terminate TLS at your reverse proxy
(Traefik). Route two domains:

- your admin domain → the `osctrl` service (`frontend_port`)
- your `osquery_host` domain → the `osctrl-tls` service (`tls_port`)

osquery **requires HTTPS** to the TLS endpoint. With a publicly trusted
certificate (e.g. Let's Encrypt via Traefik) agents can enroll using the system
CA. The environment is created without a pinned certificate; you can upload one
later from the admin UI if you terminate TLS with a private CA. Generate the
osquery quick-add / enrollment script for the `env_name` environment from the
admin UI once agents can reach the endpoint.

## Notes

- **Single node.** State lives on a local Docker volume, so `count = 1`. Pin
  placement with `constraints`; on a nomploy cluster:
  `attribute = "${meta.nomploy_control_plane}", operator = "=", value = "true"`.
- **Backups.** Back up the `db_data_volume` (PostgreSQL). Redis is a cache and
  is intentionally ephemeral.
- **Secrets.** Change `db_password`, `jwt_secret`, and `admin_password` before
  deploying anywhere reachable.
- **Idempotent bootstrap.** The init task tolerates an already-created
  environment/user, so redeploys are safe.
