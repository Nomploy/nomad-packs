Jupyter deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]/?token=<your-token>
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "work_volume" . ]]" (/home/jovyan/work) — your notebooks; back it up

Log in with the JUPYTER_TOKEN you set. Serves plain HTTP — front it with a reverse proxy for
TLS. A Jupyter server is a full Python shell, so treat the token like a root password.
