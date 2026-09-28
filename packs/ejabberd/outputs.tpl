ejabberd deployed as job "[[ var "job_name" . ]]" (host-networked).

XMPP c2s:  <node-ip>:[[ var "c2s_port" . ]]   (clients connect here, domain [[ var "xmpp_domain" . ]])
XMPP s2s:  <node-ip>:[[ var "s2s_port" . ]]   (federation)
Web admin: http://<node-ip>:[[ var "admin_port" . ]]/admin/   (login: [[ var "admin_user" . ]]@[[ var "xmpp_domain" . ]] / the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

The admin account is registered on first start. Change admin_password before
deploying anywhere real, and set xmpp_domain to a real domain (with matching DNS
SRV records) if you want federation and remote clients. Accounts and data persist
in the data_volume.
