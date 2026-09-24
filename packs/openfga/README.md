# openfga

[OpenFGA](https://openfga.dev) — a high-performance, flexible **authorization** engine inspired by Google
Zanzibar. Define relationship-based permissions ("can user X view document Y?") in an authorization model and
check them at scale over gRPC/HTTP. Ships a web **playground** for designing and testing models.

Single host-networked Nomad service using an **embedded SQLite** datastore with a persistent volume. A prestart
task runs the schema migration before the server starts.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run openfga --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `http_port` | `8080` | HTTP API port (`OPENFGA_HTTP_ADDR`). |
| `grpc_port` | `8081` | gRPC API port (`OPENFGA_GRPC_ADDR`). |
| `playground_port` | `3000` | Web playground port (`OPENFGA_PLAYGROUND_PORT`). |
| `data_volume` | `openfga_data` | `/data` — the SQLite datastore (`openfga.db`). |
| `image` | `openfga/openfga:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

Create a store and authorization model, then call check/write from your app's OpenFGA SDK. Uses the embedded
**SQLite** datastore (switch to PostgreSQL/MySQL via `OPENFGA_DATASTORE_*` for larger workloads). Runs
**without authentication** by default — keep it on an internal network, or set `OPENFGA_AUTHN_*` (preshared key
or OIDC) for production. Pin the job to the node holding the volume with `constraints`.
