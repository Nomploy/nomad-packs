draw.io deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Editor:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Stateless — draw.io runs entirely in the browser; diagrams live in your browser storage or the files
you save/export (device, Google Drive, etc.). Nothing is stored server-side. The image's Tomcat
binds port 8080; front it with a reverse proxy to serve on another port/domain.
