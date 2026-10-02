neko deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]   (admin password / user password as set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

neko streams the browser over WebRTC using the UDP port range [[ var "webrtc_epr" . ]]
(opened on the node via host networking — make sure your firewall allows it). If
the node is behind NAT, set nat1to1_ip to its public IP. Change user_password and
admin_password before deploying anywhere real. Swap `image` for a different flavour
(chromium, vlc, kde, …) — see the neko images.
