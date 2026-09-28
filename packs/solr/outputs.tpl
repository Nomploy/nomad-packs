Apache Solr deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Admin UI:  http://<node-ip>:[[ var "port" . ]]/solr/
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Create a core from the admin UI or the API, e.g.:
  curl "http://<node-ip>:[[ var "port" . ]]/solr/admin/cores?action=CREATE&name=mycore&configSet=_default"
Cores and index data persist in the data_volume at /var/solr.
