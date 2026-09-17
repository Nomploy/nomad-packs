RabbitMQ deployed as job "[[ var "job_name" . ]]" (host-networked).

AMQP:       amqp://[[ var "default_user" . ]]:<password>@<node-ip>:[[ var "amqp_port" . ]]/
Management: http://<node-ip>:[[ var "management_port" . ]]  (login [[ var "default_user" . ]] / <password>)
Discovery:  Nomad services "[[ var "job_name" . ]]" (amqp) and "[[ var "job_name" . ]]-management"
Data:       Docker volume "[[ var "data_volume" . ]]" (Mnesia: queues, users, messages) — back it up

Node name is pinned to rabbit@localhost so the data dir survives reschedules.
