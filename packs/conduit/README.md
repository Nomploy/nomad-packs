# conduit

[Conduit](https://conduit.rs) — a lightweight [Matrix](https://matrix.org) homeserver written in Rust.
Run your own federated, end-to-end-encrypted chat that works with any Matrix client (Element, etc.).
It ships as a **single binary with an embedded RocksDB database** — no PostgreSQL, no extra services.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run conduit --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `6167` | Client/federation API port (`CONDUIT_PORT`). |
| `server_name` | `matrix.example.com` | `CONDUIT_SERVER_NAME` — your domain. **Set before deploying; it's baked into every user id (`@user:server`) and can't change.** |
| `registration_token` | `change-me-…` | `CONDUIT_REGISTRATION_TOKEN` — required to create accounts. |
| `allow_federation` | `true` | Federate with other Matrix servers. |
| `data_volume` | `conduit_data` | `/var/lib/matrix-conduit` — messages, rooms, keys. |
| `image` | `matrixconduit/matrix-conduit:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Point a Matrix client at `http://<node-ip>:6167`; new users need the registration token.

**Federation & TLS:** for other servers (and most clients) to reach you, `server_name` must resolve to
this host and be served over **HTTPS on 443**, or you must advertise the Conduit port via a
`/.well-known/matrix/server` file or a `_matrix._tcp` SRV record. Put a TLS reverse proxy in front. Pin
the job to the node holding the volume with `constraints`.
