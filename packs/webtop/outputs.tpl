Webtop deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Home:      Docker volume "[[ var "config_volume" . ]]" (/config) — your desktop home; back it up

A full Linux desktop streams to your browser. Change the image tag to switch flavor (ubuntu-xfce, alpine-kde,
debian-mate, fedora-i3, …). It gives shell + GUI access, so NEVER expose it to the internet without an
authenticating reverse proxy over TLS. Set a password/auth in front and treat it like remote root access.
