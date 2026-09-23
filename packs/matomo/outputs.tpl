Matomo deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Tasks: init (chown app dir) + mariadb (prestart sidecar, on :3306) + matomo (app).

Complete the web installer on first visit — the database is pre-filled (host 127.0.0.1, db "matomo",
user "matomo", your db_password). Add your first website and grab the tracking snippet.

App files/config live on [[ var "data_volume" . ]] (/var/www/html); analytics data in MariaDB
([[ var "db_data_volume" . ]]). The app's Apache binds port 80 (front with a reverse proxy to serve
elsewhere) and the DB uses 3306. Pin the job to the node holding the volumes with the constraints
variable.
