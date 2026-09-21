app {
  url = "https://www.jaegertracing.io"
}

pack {
  name        = "jaeger"
  description = "Jaeger — open-source distributed tracing: collect, store, and visualize traces to debug latency and dependencies across services. Deployed as the all-in-one image (in-memory storage) as a stateless host-networked Nomad service with an OTLP collector and the query UI."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/jaeger"
  version     = "0.1.0"
}
