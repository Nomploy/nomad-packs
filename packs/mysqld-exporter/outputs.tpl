MySQLd Exporter deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Metrics:   http://<node-ip>:[[ var "port" . ]]/metrics
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Scraping:  [[ var "mysql_address" . ]] as user "[[ var "mysql_user" . ]]"

Create the monitoring user first (least privilege):
  CREATE USER 'exporter'@'%' IDENTIFIED BY '...' WITH MAX_USER_CONNECTIONS 3;
  GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'%';

Scrape it from Prometheus (the monitoring pack):
  - job_name: mysql
    static_configs:
      - targets: ['127.0.0.1:[[ var "port" . ]]']
