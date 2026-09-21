app {
  url = "https://prometheus.io/docs/alerting/latest/alertmanager/"
}

pack {
  name        = "alertmanager"
  description = "Prometheus Alertmanager — handles alerts sent by Prometheus: deduplicates, groups, silences, and routes them to receivers (email, Slack, webhooks, ntfy/gotify, …). Deployed as a host-networked Nomad service with a rendered starter config on a persistent volume. Pairs with the monitoring pack."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/alertmanager"
  version     = "0.1.0"
}
