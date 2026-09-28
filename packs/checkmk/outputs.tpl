Checkmk deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]/cmk/   (login: cmkadmin / the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

On first start a monitoring site named "cmk" is created with the cmkadmin
password you set. Change admin_password before deploying anywhere real. Sites,
configuration and all monitoring data persist in the data_volume at /omd/sites.
