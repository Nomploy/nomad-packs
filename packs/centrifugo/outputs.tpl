Centrifugo deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Admin UI:  http://<node-ip>:[[ var "port" . ]]   (log in with the admin_password you set)
API:       http://<node-ip>:[[ var "port" . ]]/api   (use the api_key as the authorization key)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Change admin_password, admin_secret, api_key and token_hmac_secret before
deploying anywhere real. Clients connect with JWTs signed by token_hmac_secret;
your backend publishes to channels via the HTTP API using api_key.
