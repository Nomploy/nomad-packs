Mosquitto deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

MQTT:      <node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (persistence DB)
Auth:      [[ if var "allow_anonymous" . ]]anonymous allowed (OPEN) — set allow_anonymous=false + a password file for real use[[ else ]]anonymous disabled (add a password file)[[ end ]]

Test:
  mosquitto_sub -h <node-ip> -p [[ var "port" . ]] -t test &
  mosquitto_pub -h <node-ip> -p [[ var "port" . ]] -t test -m hello
