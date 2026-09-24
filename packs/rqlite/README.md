# rqlite

[rqlite](https://rqlite.io) — a lightweight, distributed relational database built on **SQLite** with
**Raft** consensus. You get SQLite's simplicity and a friendly HTTP API, plus fault-tolerant replication
across nodes when you want high availability.

Single host-networked node with a persistent data volume (join more nodes to form an HA cluster).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run rqlite --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `http_port` | `4001` | HTTP API port (`-http-addr`). |
| `raft_port` | `4002` | Raft consensus port (`-raft-addr`). |
| `data_volume` | `rqlite_data` | `/rqlite/file` — the SQLite database and Raft log. |
| `image` | `rqlite/rqlite:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Query over HTTP:

```sh
curl -G 'http://<node-ip>:4001/db/query' --data-urlencode 'q=SELECT 1'
```

This runs a single **durable** node. For **high availability**, deploy more instances and `-join` them to
this node's raft address. The API is unauthenticated — keep it on an internal network or configure auth.
Pin the job to the node holding the volume with `constraints`.
