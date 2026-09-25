coturn deployed as job "[[ var "job_name" . ]]" (host-networked).

TURN/STUN: [[ var "realm" . ]]:[[ var "port" . ]] (TCP + UDP)
Relay:     UDP [[ var "min_port" . ]]-[[ var "max_port" . ]] (open this range on the firewall)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Configure your app with:
  urls: turn:[[ var "realm" . ]]:[[ var "port" . ]]   username: [[ var "turn_user" . ]]   credential: <turn_password>

IMPORTANT: the UDP relay range must be reachable from the internet, and set external_ip if the node is behind
1:1 NAT. Because it's host-networked, the relay ports bind directly (no per-port docker-proxy). Use it as the TURN
server for jitsi, Nextcloud Talk, or the conduit (Matrix) pack.
