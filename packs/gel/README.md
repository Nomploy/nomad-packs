# gel

[Gel](https://www.geldata.com) (formerly **EdgeDB**) is a modern
graph-relational database built on top of PostgreSQL. It pairs a strict,
typed schema with **EdgeQL** — an expressive query language designed to avoid
SQL's awkwardness with nested/related data — plus first-class migrations,
access policies, computed properties and built-in auth. You get Postgres'
reliability with a far nicer developer experience.

This pack runs Gel as a single host-networked Nomad service. The image bundles
its own PostgreSQL, so there's nothing else to deploy.

## Deploy

```bash
nomad-pack run gel --registry=nomploy \
  --var server_password=$(openssl rand -hex 16)
```

Gel generates a self-signed TLS certificate on first boot and serves on port
5656. Connect with the [`gel` CLI](https://docs.geldata.com) or a client library.

## Configuration

| Variable          | Default                | Description                                       |
| ----------------- | ---------------------- | ------------------------------------------------- |
| `image`           | `geldata/gel:latest`   | Container image (pin a tag in production).           |
| `port`            | `5656`                 | Host port for the server.                          |
| `server_password` | `gel_change_me`        | Password for the `admin` user — **change this**.    |
| `tls_cert_mode`   | `generate_self_signed` | TLS cert mode (auto self-signed by default).        |
| `data_volume`     | `gel_data`             | Volume for data + bundled PostgreSQL.               |
| `resources`       | 1000 MHz / 1024 MB     | CPU and memory for the task.                         |

The database (and its embedded PostgreSQL) persists in `data_volume`. Since the
cert is self-signed, point clients at the server with TLS verification set to
insecure, or mount a trusted certificate and set `tls_cert_mode=require_file`.
