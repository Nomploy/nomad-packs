app {
  url = "https://www.netdata.cloud"
}

pack {
  name        = "netdata"
  description = "Netdata — real-time, per-second infrastructure monitoring with thousands of auto-detected metrics, interactive charts, and health alarms, out of the box. Deployed as a host-networked Nomad service that reads the host's /proc, /sys, and Docker socket, with persistent config/lib/cache volumes."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/netdata"
  version     = "0.1.0"
}
