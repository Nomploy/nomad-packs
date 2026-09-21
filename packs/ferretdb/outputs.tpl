FerretDB deployed as job "[[ var "job_name" . ]]" (FerretDB + DocumentDB PostgreSQL, host-networked).

MongoDB URI: mongodb://[[ var "db_user" . ]]:<db_password>@<node-ip>:[[ var "port" . ]]/
Discovery:   Nomad service "[[ var "job_name" . ]]" (provider=nomad) on the Mongo port
State:       Docker volume "[[ var "db_data_volume" . ]]" (Postgres — all your documents) — back it up

Point any MongoDB driver/tool at the URI above (auth uses the Postgres credentials). Example:
  mongosh "mongodb://[[ var "db_user" . ]]:<db_password>@<node-ip>:[[ var "port" . ]]/"
