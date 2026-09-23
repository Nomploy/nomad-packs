app {
  url = "https://etcd.io"
}

pack {
  name        = "etcd"
  description = "etcd — a distributed, strongly-consistent key/value store (the datastore behind Kubernetes), with a gRPC API and watch/lease primitives for config and coordination. Deployed here as a single node, host-networked with a data volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/etcd"
  version     = "0.1.0"
}
