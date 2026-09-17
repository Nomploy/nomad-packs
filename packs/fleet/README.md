# fleet

[Fleet](https://fleetdm.com) — open-source device management built on osquery, for
querying and managing laptops and servers at scale (inventory, vulnerabilities,
policies, optional MDM).

This pack is **all-in-one**: it runs the Fleet server together with its two required
dependencies — **MySQL 8** and **Redis** — in a single host-networked Nomad job. The
dependencies start first (prestart sidecars) and share the host network namespace, so
Fleet reaches them on `127.0.0.1`. On start, Fleet waits for MySQL, runs its schema
migrations (`fleet prepare db`), then serves the UI/API.

Good for a single-node or small deployment. To scale Fleet horizontally, run it against
an **external** MySQL/Redis instead (see *Production notes*).

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run fleet --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `fleet`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Once it's up, open `http://<node-ip>:8080` and complete the first-run wizard to create the
initial admin user. Generate an enroll secret / installer from the UI to enroll hosts.

## What it deploys

- **Fleet server** — plain HTTP on `port` (default `8080`), TLS off. Front it with a
  reverse proxy (Traefik) for TLS.
- **MySQL 8** — persistent named volume for `/var/lib/mysql`. This is the only critical
  state; **back it up**.
- **Redis 7** — AOF persistence on a named volume (live/query state; not fatal to lose).

`count` is fixed to `1` — a second alloc would start its own MySQL/Redis and fight over the
same volumes. Pin the job to one node with `constraints` so the local volumes stay put.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `fleet_image` | `fleetdm/fleet:latest` | **Pin a tag in production** — Fleet migrates the DB on start. |
| `port` | `8080` | Fleet UI/API host port (HTTP). |
| `server_tls` | `false` | Keep false; terminate TLS at a proxy. |
| `server_private_key` | `""` | Optional base64 32-byte key (`openssl rand -base64 32`) enabling MDM / encrypted secrets. |
| `mysql_password` / `mysql_root_password` | `fleet` | **Change these.** |
| `mysql_data_volume` | `fleet_mysql_data` | Critical state — back up. |
| `mysql_port` / `redis_port` | `3306` / `6379` | Host ports for the bundled deps. |
| `constraints` | `[]` | Pin to a node so volumes stay put. |

See `variables.hcl` for the full list (images, credentials, per-task resources).

## Production notes

- **Pin `fleet_image`.** Running `:latest` can pull a new major on reschedule, which
  migrates your database irreversibly.
- **TLS:** this pack serves HTTP only. Put Fleet behind a reverse proxy that terminates
  TLS; osquery agents require a trusted TLS endpoint to enroll.
- **Backups:** snapshot the MySQL volume. Redis can be rebuilt from scratch.
- **Scaling:** for HA / multiple Fleet replicas, drop the bundled MySQL/Redis and point
  Fleet at managed/external instances (a future `external`-mode variant, or edit the
  rendered job's `FLEET_MYSQL_ADDRESS` / `FLEET_REDIS_ADDRESS`).
