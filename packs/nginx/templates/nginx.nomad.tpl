job "[[ var "job_name" . ]]" {
  namespace   = "[[ var "namespace" . ]]"
  datacenters = [[ var "datacenters" . | toStringList ]]
  type        = "service"

  group "[[ var "job_name" . ]]" {
    count = [[ var "count" . ]]

    network {
      mode = "host"
      port "http" {
        static = [[ var "port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "http"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "nginx" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        # Nomad auto-mounts the alloc's local/ dir at /local, so the rendered
        # config + site are available without any host bind mount.
        args         = ["nginx", "-c", "/local/nginx.conf", "-g", "daemon off;"]
      }

      template {
        destination = "local/nginx.conf"
        data        = <<EOH
worker_processes 1;
error_log /dev/stderr warn;
pid /local/nginx.pid;
events { worker_connections 1024; }
http {
  include       /etc/nginx/mime.types;
  default_type  application/octet-stream;
  access_log    /dev/stdout;
  sendfile      on;
  server {
    listen [[ var "port" . ]];
    root   /local/www;
    index  index.html;
    location / { try_files $uri $uri/ =404; }
  }
}
EOH
      }

      template {
        destination = "local/www/index.html"
        data        = <<EOH
[[ var "index_html" . ]]
EOH
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
