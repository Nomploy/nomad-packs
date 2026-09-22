File Browser deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

First start initializes the database and an admin account. Check the task logs for the
randomly generated admin password (older images default to admin / admin):
  nomad alloc logs -task filebrowser <alloc>
Change the password immediately under Settings -> User Management.

Volumes (Docker named):
  - [[ var "files_volume" . ]] -> /srv                     (the files you manage)
  - [[ var "data_volume" . ]]  -> /database/filebrowser.db (users, settings, shares)

Pin the job to the node holding the volumes with the constraints variable.
