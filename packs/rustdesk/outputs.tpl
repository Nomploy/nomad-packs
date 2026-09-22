RustDesk Server deployed as job "[[ var "job_name" . ]]" (host-networked; hbbs + hbbr).

Ports: 21115/tcp (ID reg), 21116/tcp+udp (ID/rendezvous), 21117/tcp (relay), 21118/tcp, 21119/tcp (web-client WS)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Point the RustDesk client at this host: set "ID Server" to <node-ip> (and "Relay Server" too, or
set the relay_host variable). Copy the PUBLIC KEY the server generates on first start — clients
need it (the "Key" field). It's in the [[ var "data_volume" . ]] volume (/data/id_ed25519.pub):
  nomad alloc exec -task rustdesk <alloc> cat /data/id_ed25519.pub

For internet use, forward 21115-21119 (TCP) and 21116 (UDP) to this node. Pin the job to the node
holding the volume with the constraints variable.
