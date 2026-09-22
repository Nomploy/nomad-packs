# neo4j

[Neo4j](https://neo4j.com) — the popular open-source **graph database**, with the Cypher
query language and the Neo4j Browser UI. Great for connected data: social graphs,
recommendations, fraud, knowledge graphs. Host-networked Nomad service with a persistent
volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run neo4j --registry nomploy --var password=<8+ chars>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `neo4j`, set `password`, then
Deploy. Open the Browser at `http://<node-ip>:7474` (login `neo4j` / your password); drivers
connect via Bolt at `bolt://<node-ip>:7687`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `neo4j:5` | Pin a tag in production. |
| `http_port` / `bolt_port` | `7474` / `7687` | Browser/HTTP + Bolt. |
| `password` | `changeme123` | Initial `neo4j` password — **≥ 8 chars, not "neo4j". Change it.** |
| `data_volume` | `neo4j_data` | Graph store. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 1000 / mem 1024` | JVM — raise for larger graphs. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). A prestart task chowns the volume to
  uid 7474 (the neo4j user). Pin with `constraints`.
- The password is set on **first boot** (empty volume); change it later via Cypher, not the
  variable. This is Neo4j Community Edition (the `neo4j:5` image).
- Front with a reverse proxy for TLS and keep it internal.
