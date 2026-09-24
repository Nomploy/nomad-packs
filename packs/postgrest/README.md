# postgrest

[PostgREST](https://postgrest.org) — serves a full RESTful API straight from a PostgreSQL database. Your
schema, views, functions, and roles *are* the API; it handles CRUD, filtering, pagination, JWT auth, and
delegates authorization to PostgreSQL row-level security — no backend code to write.

Single host-networked Nomad service. **Stateless** (bring your own PostgreSQL) — raise `count` to scale.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run postgrest --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3027` | REST API port (`PGRST_SERVER_PORT`). |
| `db_uri` | `postgres://authenticator:change-me@127.0.0.1:5432/postgres` | Connection URI (`PGRST_DB_URI`). Point at your database. |
| `db_schema` | `public` | Schema(s) to expose (`PGRST_DB_SCHEMAS`). |
| `db_anon_role` | `web_anon` | Role for unauthenticated requests (`PGRST_DB_ANON_ROLE`). |
| `jwt_secret` | `""` | JWT verification secret (`PGRST_JWT_SECRET`); empty = anonymous only. |
| `count` | `1` | Instances to run (stateless — safe to scale). |
| `image` | `postgrest/postgrest:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Pairs with the `postgres` pack (co-located on the node, reachable at `127.0.0.1:5432`). Create an
`authenticator` login role plus an anonymous role, then hit `http://<node-ip>:3027/<table>`. Set a JWT
secret for authenticated, role-based access. See the PostgREST docs for the schema/role setup.
