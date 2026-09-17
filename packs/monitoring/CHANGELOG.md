# Changelog

## 0.1.0

- Initial release: all-in-one observability stack — Prometheus + node-exporter +
  cAdvisor + Grafana in a single host-networked Nomad job. node-exporter and cAdvisor
  run as prestart sidecars; Prometheus scrapes them on 127.0.0.1 with a rendered
  scrape config (optional Nomad target); Grafana ships with the Prometheus datasource
  pre-provisioned. Persistent volumes for the Prometheus TSDB and Grafana. cAdvisor is
  toggleable, and the whole stack runs unprivileged.
