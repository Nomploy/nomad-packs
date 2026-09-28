Homer deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Dashboard: http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

On first start Homer seeds an example config into the assets_volume. Edit
config.yml in that volume (at /www/assets/config.yml) to add your services and
links, then refresh the page.
