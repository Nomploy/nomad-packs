Traefik deployed as job "[[ var "job_name" . ]]" (host-networked).

HTTP:      :[[ var "http_port" . ]]   HTTPS: :[[ var "https_port" . ]]
Dashboard: http://<node-ip>:[[ var "dashboard_port" . ]]/dashboard/   (insecure — keep internal)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Traefik reads services from Nomad ([[ var "nomad_address" . ]]). Expose a job by adding Traefik tags to its
Nomad service, e.g.:
  tags = ["traefik.enable=true", "traefik.http.routers.myapp.rule=Host(`app.example.com`)"]

NOTE: this binds ports [[ var "http_port" . ]]/[[ var "https_port" . ]] — don't run it on a node that
already has another ingress (e.g. a nomploy control plane's own Traefik) on those ports. For TLS, add an
ACME/certResolver config and a certs volume. If Nomad ACLs are on, set nomad_token.
