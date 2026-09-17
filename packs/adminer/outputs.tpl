Adminer deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
[[ if ne (var "default_server" .) "" ]]Login page pre-fills server "[[ var "default_server" . ]]".[[ else ]]On the login page pick the system (PostgreSQL/MySQL/…) and enter server host:port + credentials.[[ end ]]

Stateless — no volume. For the postgres pack use server 127.0.0.1:5432 (same node) or
<node-ip>:5432; for mariadb, port 3306.
