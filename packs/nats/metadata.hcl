app {
  url = "https://nats.io"
}

pack {
  name        = "nats"
  description = "NATS — a lightweight, high-performance messaging system (pub/sub, request-reply, queues) with JetStream persistence enabled. Deployed as a host-networked Nomad service with a persistent Docker volume for the JetStream store and the HTTP monitoring endpoint on."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/nats"
  version     = "0.1.0"
}
