Restic REST Server deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Endpoint:  rest:http://<node-ip>:[[ var "port" . ]]/
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Auth:      [[ if var "disable_auth" . ]]DISABLED (trusted network only)[[ else ]]HTTP basic (create users below)[[ end ]]
Mode:      [[ if var "append_only" . ]]append-only (clients cannot delete snapshots)[[ else ]]read-write[[ end ]]

Use it from a restic client:
  export RESTIC_REPOSITORY="rest:http://<node-ip>:[[ var "port" . ]]/myrepo"
  export RESTIC_PASSWORD="..."      # your repo encryption password
  restic init && restic backup /path

[[ if var "disable_auth" . ]]Auth is off — restrict access to a trusted network / front with TLS + auth.
[[ else ]]Create users (writes .htpasswd on the volume):
  nomad alloc exec -task rest-server <alloc> create_user <username>
Then use rest:http://<username>:<password>@<node-ip>:[[ var "port" . ]]/
[[ end ]]
Point the backup pack's repository at this server. Append-only protects history from a
compromised client — run forget/prune from the server side.
