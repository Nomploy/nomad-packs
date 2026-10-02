# cassandra

[Apache Cassandra](https://cassandra.apache.org) is a distributed, highly
available wide-column NoSQL database. It's built for huge write throughput and
linear scalability with no single point of failure, tunable consistency, and a
masterless peer-to-peer design — the engine behind many very large datasets.

This pack runs a single Cassandra node as a host-networked Nomad service.

## Deploy

```bash
nomad-pack run cassandra --registry=nomploy
```

Connect with `cqlsh <node-ip> 9042` or any Cassandra driver.

## Configuration

| Variable         | Default            | Description                                    |
| ---------------- | ------------------ | ---------------------------------------------- |
| `image`          | `cassandra:5`      | Container image (pin a tag in production).        |
| `port`           | `9042`             | CQL native protocol.                            |
| `internode_port` | `7000`             | Inter-node communication (for a future cluster).|
| `cluster_name`   | `Nomploy Cluster`  | Cassandra cluster name.                          |
| `max_heap_size`  | `2G`               | JVM max heap — **keep within the memory limit**. |
| `heap_newsize`   | `400M`             | JVM young-generation size.                       |
| `data_volume`    | `cassandra_data`   | Volume for data (`/var/lib/cassandra`).          |
| `resources`      | 1500 MHz / 3072 MB | CPU and memory (Cassandra is memory-heavy).      |

> **Heap:** by default the image sizes the JVM heap from *host* RAM, which will
> exceed the task's cgroup limit and get OOM-killed — this pack pins
> `MAX_HEAP_SIZE`/`HEAP_NEWSIZE` so it fits. Keep them comfortably below
> `resources.memory`. Authentication is open by default; enable
> `PasswordAuthenticator` before exposing. Data persists in `data_volume`.
