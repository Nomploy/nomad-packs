Mailpit deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    http://<node-ip>:[[ var "ui_port" . ]]  (view captured mail)
SMTP:      <node-ip>:[[ var "smtp_port" . ]]  (point your app's SMTP client here, no auth/TLS needed)
Discovery: Nomad services "[[ var "job_name" . ]]" (ui) and "[[ var "job_name" . ]]-smtp"

Stateless — messages are held in memory and cleared on restart. Configure your app:
SMTP host <node-ip>, port [[ var "smtp_port" . ]]. Nothing is delivered to real inboxes.
