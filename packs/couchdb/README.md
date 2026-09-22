# couchdb

[Apache CouchDB](https://couchdb.apache.org) — a **document database** with a JSON document
model, a friendly HTTP/REST API, and multi-master **replication** (ideal for offline-first
and sync apps, e.g. with PouchDB). Host-networked Nomad service with a persistent volume and
the Fauxton admin UI.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run couchdb --registry nomploy --var admin_password=<secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `couchdb`, set
`admin_password`, then Deploy. Fauxton UI at `http://<node-ip>:5984/_utils`.

On a fresh single node, run the one-time single-node setup (see the deploy output) so the
`_users`/`_replicator` system databases are created.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `couchdb:3` | Pin a tag in production. |
| `port` | `5984` | HTTP API + Fauxton. |
| `admin_user` / `admin_password` | `admin` / `couchdb` | Created on **first boot**. **Change the password.** |
| `data_volume` | `couchdb_data` | The databases. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise for larger datasets. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). A prestart task chowns the volume to
  uid 5984 (the couchdb user). Pin with `constraints`. (CouchDB also clusters — out of scope.)
- Don't expose it publicly without the admin set up first; front with a reverse proxy for TLS.
