Manticore Search deployed as job "[[ var "job_name" . ]]" (host-networked).

SQL (MySQL):  mysql -h <node-ip> -P [[ var "sql_port" . ]]
HTTP/JSON:    http://<node-ip>:[[ var "http_port" . ]]
Discovery:    Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:         Docker volume "[[ var "data_volume" . ]]" (/var/lib/manticore) — tables/indexes; back it up

Create tables and search via SQL (any MySQL client) or the HTTP/JSON API, e.g.:
  curl <node-ip>:[[ var "http_port" . ]]/search -d '{"table":"products","query":{"match":{"*":"phone"}}}'
Supports full-text, filtering, faceting, autocomplete, and vector search. The ports are unauthenticated —
keep them on an internal network.
