Bark server deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API:       http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Install the Bark iOS app, point it at http://<node-ip>:[[ var "port" . ]] (or your public
URL behind a reverse proxy), and it registers a device key. Then push a notification with:
  curl http://<node-ip>:[[ var "port" . ]]/<your-device-key>/Hello/World

Device registrations are stored in the bark_data volume. Put it behind HTTPS (a reverse
proxy) for real use — iOS requires a reachable URL.
