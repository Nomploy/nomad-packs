Frigate deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    http://<node-ip>:[[ var "port" . ]]   (create the admin account on first visit)
RTSP:      rtsp://<node-ip>:[[ var "rtsp_port" . ]]   (internal restream via go2rtc)
WebRTC:    <node-ip>:[[ var "webrtc_port" . ]]   (live low-latency view)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Frigate starts with an empty camera list. Edit /config/config.yml (in the
config_volume) to add your cameras, then restart the job. See
https://docs.frigate.video for the full config reference.
