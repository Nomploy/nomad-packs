# consul

[Consul](https://www.consul.io) — HashiCorp's service networking layer: a key/value store, service
discovery, health checking, and DNS. Handy alongside Nomad for application config and cross-service
discovery.

Single-node **server** with the web UI, host-networked with a data volume. A busybox prestart task
chowns the data volume to Consul's UID.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run consul --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `http_port` | `8500` | HTTP API + web UI. |
| `dns_port` | `8600` | DNS interface (TCP + UDP). |
| `uid` | `100` | User Consul runs as; data volume is chown'd to it. |
| `data_volume` | `consul_data` | `/consul/data` — KV store, state. |
| `image` | `hashicorp/consul:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> This is a **single-node, ACL-open** server for KV/config/discovery on a trusted network. For
> production, run an HA cluster with gossip encryption and ACLs. Pin the job to the node holding the
> volume with `constraints`.
