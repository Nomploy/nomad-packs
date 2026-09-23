Wakapi deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Sign up on first visit to get your API key, then point your editor's WakaTime plugin at this server
via ~/.wakatime.cfg:
  api_url = http://<node-ip>:[[ var "port" . ]]/api
  api_key = <your key from the dashboard>

Database lives on the [[ var "data_volume" . ]] volume (/data) — back it up and pin the job to that
node with the constraints variable. Set a long random password_salt.
