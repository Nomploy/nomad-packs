# Changelog

## 0.1.0

- Initial release: Neo4j 5 as a host-networked Nomad service with a prestart chown so it
  (uid 7474) can write its persistent volume, an initial password via NEO4J_AUTH, HTTP + Bolt
  listeners bound to all interfaces on configurable ports, and Nomad service discovery.
