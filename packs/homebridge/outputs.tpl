Homebridge deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Config UI X: http://<node-ip>:[[ var "port" . ]]
Default login: admin / admin (change it on first sign-in).
Discovery:   Nomad service "[[ var "job_name" . ]]" (provider=nomad)

HomeKit pairing needs Avahi/mDNS on the host network, which host networking
provides. Add the bridge in the Apple Home app using the PIN shown in the UI.
