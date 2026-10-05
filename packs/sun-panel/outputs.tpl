Sun-Panel deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Sun-Panel stores its config, SQLite database and uploads in the sun_panel_conf volume
(/app/conf). Sign in with the default admin account:

  username: admin@sun.cc
  password: 12345678

Change the password immediately. Then add your app bookmarks and icons. The web server
listens on port 3002 inside the container; keep the port variable at 3002 unless you also
change http_port in /app/conf/conf.ini.
