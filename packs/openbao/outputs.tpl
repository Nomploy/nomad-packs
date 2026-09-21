OpenBao deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API/UI:    http://<node-ip>:[[ var "port" . ]]  (UI at /ui)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Storage:   Docker volume "[[ var "data_volume" . ]]" (encrypted secrets) — back it up

ONE-TIME SETUP (required — OpenBao starts SEALED):
  export BAO_ADDR=http://<node-ip>:[[ var "port" . ]]
  bao operator init            # prints unseal keys + initial root token — SAVE THESE SAFELY
  bao operator unseal          # run 3x with 3 different unseal keys
(You can also do this in the web UI at /ui.) After a restart you must unseal again.
Serves plain HTTP — front with a reverse proxy for TLS before real use.
