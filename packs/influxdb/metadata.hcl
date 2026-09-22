app {
  url = "https://www.influxdata.com"
}

pack {
  name        = "influxdb"
  description = "InfluxDB 2 — a purpose-built time-series database with a built-in UI, dashboards, and the Flux/InfluxQL query languages. Great for metrics and IoT sensor data. Deployed as a host-networked Nomad service that initializes an admin/org/bucket on first boot, with a persistent volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/influxdb"
  version     = "0.1.0"
}
