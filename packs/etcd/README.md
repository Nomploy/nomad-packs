# etcd

[etcd](https://etcd.io) — a distributed, strongly-consistent key/value store (the datastore behind
Kubernetes), with a gRPC API and watch/lease primitives for configuration and coordination.

Single node, host-networked with a data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run etcd --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `client_port` | `2379` | Client (gRPC/HTTP) API. |
| `peer_port` | `2380` | Peer communication. |
| `advertise_host` | `127.0.0.1` | Advertised client host — **set the node IP for remote clients.** |
| `data_volume` | `etcd_data` | `/etcd-data`. |
| `image` | `quay.io/coreos/etcd:v3.5.16` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Single node with **no authentication** — keep it on a trusted network. `advertise_host` must be
> reachable by clients (`127.0.0.1` only works for co-located ones). Pin the job to the node holding
> the volume with `constraints`.
