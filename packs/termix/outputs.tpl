Termix deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Bundled: guacd (Apache Guacamole proxy daemon, prestart sidecar on port
[[ var "guacd_port" . ]]) for RDP/VNC sessions; the Termix app and guacd share the
termix_data volume (inventory, settings, session recordings, RDP drive).

Open the UI and create the first admin account, then add your SSH / RDP / VNC
hosts. Termix stores everything in the data volume — no external database needed.
It manages credentials for the hosts you add, so keep it behind your VPN or a
reverse proxy with authentication and back up the data volume.
