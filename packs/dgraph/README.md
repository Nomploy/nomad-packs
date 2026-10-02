# dgraph

[Dgraph](https://dgraph.io) is a distributed, horizontally scalable graph
database. It serves a **native GraphQL API** (no resolvers to write) alongside
its own graph query language (DQL), with ACID transactions, full-text/geo
indexing and a sharded, replicated storage engine designed for large graphs.

This pack runs the **standalone** Dgraph image (Zero + Alpha bundled in one
container) as a single host-networked Nomad service — ideal for a single node.

## Deploy

```bash
nomad-pack run dgraph --registry=nomploy
```

Load a schema and query:

```bash
curl -X POST http://<node-ip>:8080/admin/schema --data-binary 'type Person { name: String! @index(term) }'
curl -X POST http://<node-ip>:8080/graphql -H 'Content-Type: application/json' -d '{"query":"{ queryPerson { name } }"}'
```

## Configuration

| Variable      | Default                   | Description                                 |
| ------------- | ------------------------- | ------------------------------------------- |
| `image`       | `dgraph/standalone:latest`| Container image (pin a tag in production).      |
| `http_port`   | `8080`                    | Alpha HTTP / GraphQL API.                    |
| `grpc_port`   | `9080`                    | Alpha gRPC API (client libraries).           |
| `data_volume` | `dgraph_data`             | Volume for data (`/dgraph`).                  |
| `resources`   | 1000 MHz / 2048 MB        | CPU and memory for the task.                  |

> The standalone image bundles Dgraph Zero and Alpha for single-node use. For a
> production cluster (replication, sharding), deploy Zero and Alpha as separate
> jobs. Data persists in `data_volume`.
