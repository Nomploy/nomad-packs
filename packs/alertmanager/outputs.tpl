Alertmanager deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

UI/API:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (silences + notification log)

Point Prometheus at it (in the monitoring pack's prometheus.yml):
  alerting:
    alertmanagers:
      - static_configs:
          - targets: ['127.0.0.1:[[ var "port" . ]]']

The default config drops alerts to a no-op receiver — set the `config` var to real
routes/receivers (email, Slack, or a webhook to the ntfy/gotify packs).
