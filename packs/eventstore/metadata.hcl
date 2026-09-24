app {
  url = "https://www.kurrent.io"
}

pack {
  name        = "eventstore"
  description = "EventStoreDB (Kurrent) — a purpose-built database for event sourcing: an append-only log of immutable events with streams, subscriptions, and built-in projections, plus a web admin UI. Deployed as a host-networked single-node Nomad service (insecure/dev mode) with persistent data and log volumes."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/eventstore"
  version     = "0.1.0"
}
