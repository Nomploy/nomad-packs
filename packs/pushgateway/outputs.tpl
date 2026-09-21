Pushgateway deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Endpoint:  http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Push a metric from a batch job:
  echo "some_metric 42" | curl --data-binary @- http://<node-ip>:[[ var "port" . ]]/metrics/job/my_batch

Then scrape it in the monitoring pack's prometheus.yml (set honor_labels: true):
  - job_name: pushgateway
    honor_labels: true
    static_configs:
      - targets: ['127.0.0.1:[[ var "port" . ]]']
