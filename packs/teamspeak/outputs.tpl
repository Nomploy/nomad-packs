TeamSpeak 3 deployed as job "[[ var "job_name" . ]]" (host-networked).

Connect:   <node-ip>:[[ var "voice_port" . ]]  (in the TeamSpeak client)
ServerQuery: <node-ip>:[[ var "query_port" . ]]   File transfer: [[ var "filetransfer_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/var/ts3server) — DB + config; back it up

IMPORTANT: on first boot the server prints the admin "ServerAdmin privilege key" (token) in the task logs —
grab it from `nomad alloc logs` and paste it into your client once to claim admin. Voice is UDP on
[[ var "voice_port" . ]]. Uses the free non-commercial TeamSpeak license (TS3SERVER_LICENSE=accept).
