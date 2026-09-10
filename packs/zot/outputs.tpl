zot registry deployed as job "[[ .zot.job_name ]]" (host-networked on port [[ .zot.port ]]).

Reachable at:  <node-ip>:[[ .zot.port ]]
Auth:          [[ if ne .zot.htpasswd "" ]]authenticated push, [[ if .zot.anonymous_pull ]]anonymous pull[[ else ]]auth required for pull[[ end ]][[ else ]]OPEN — no authentication[[ end ]]

Next steps:
  1. Trust it on every node's Docker daemon (it serves HTTP): add
     "<node-ip>:[[ .zot.port ]]" to /etc/docker/daemon.json "insecure-registries",
     then: systemctl reload docker
  2. Add it in nomploy:  Settings -> Registry -> Add Registry
        URL: <node-ip>:[[ .zot.port ]]   prefix: apps[[ if ne .zot.htpasswd "" ]]   (+ your push user/pass)[[ end ]]
     nomploy's consul-template registry-auth then renders the credentials to every
     node's docker config, so private multi-node pulls work with no creds in job specs.
  3. Push:  docker push <node-ip>:[[ .zot.port ]]/apps/<image>
