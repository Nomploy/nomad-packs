Swagger UI deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Spec:      [[ var "spec_url" . ]]

Stateless — no volumes, safe to scale via `count`. Set spec_url to your API's OpenAPI/Swagger spec.
If the spec is on another origin, that server must send permissive CORS headers for the browser to
load it.
