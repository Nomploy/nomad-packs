Syncthing deployed as job "[[ var "job_name" . ]]" (host-networked).

Web GUI:   http://<node-ip>:[[ var "gui_port" . ]]
Sync:      TCP + QUIC/UDP on port [[ var "sync_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

The GUI binds on all interfaces (STGUIADDRESS=0.0.0.0) so it's reachable — SET A GUI
USERNAME/PASSWORD immediately under Actions -> Settings, and front it with TLS.

Local discovery also uses UDP 21027 (broadcast). Add remote devices by their Device ID;
if this node is behind NAT, forward TCP/UDP [[ var "sync_port" . ]] or rely on Syncthing's
relays.

Config, keys, and the default folder live on the [[ var "data_volume" . ]] volume
(/var/syncthing) — pin the job to that node with the constraints variable.
