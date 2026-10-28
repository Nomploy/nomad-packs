job "[[ var "job_name" . ]]" {
  namespace   = "[[ var "namespace" . ]]"
  datacenters = [[ var "datacenters" . | toStringList ]]
  type        = "service"

  [[- range $c := var "constraints" . ]]
  constraint {
    attribute = "[[ $c.attribute ]]"
    operator  = "[[ $c.operator ]]"
    value     = "[[ $c.value ]]"
  }
  [[- end ]]

  # All-in-one osctrl: Postgres + Redis come up first (prestart sidecars), an
  # init task seeds the environment + admin user (the osctrl-cli auto-migrates
  # the schema), then tls + api + the React frontend start. Everything shares
  # the host loopback, so services reach each other on 127.0.0.1. count stays 1
  # (local Postgres volume).
  group "[[ var "job_name" . ]]" {
    count = 1

    network {
      mode = "host"
      port "http" {
        static = [[ var "frontend_port" . ]]
      }
      port "tls" {
        static = [[ var "tls_port" . ]]
      }
      port "api" {
        static = [[ var "api_port" . ]]
      }
      port "db" {
        static = [[ var "db_port" . ]]
      }
      port "redis" {
        static = [[ var "redis_port" . ]]
      }
    }

    # Admin UI — front this with your reverse proxy for TLS.
    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "http"
    }

    # osquery TLS endpoint — agents enroll/report here (also behind TLS).
    service {
      name     = "[[ var "job_name" . ]]-tls"
      provider = "nomad"
      port     = "tls"
    }

    restart {
      attempts = 5
      interval = "10m"
      delay    = "20s"
      mode     = "delay"
    }

    # --- PostgreSQL (prestart sidecar) ------------------------------------
    task "postgres" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "postgres_image" . ]]"
        network_mode = "host"
        ports        = ["db"]

        mount {
          type   = "volume"
          source = "[[ var "db_data_volume" . ]]"
          target = "/var/lib/postgresql/data"
        }
      }

      env {
        POSTGRES_DB       = "[[ var "db_name" . ]]"
        POSTGRES_USER     = "[[ var "db_user" . ]]"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    # --- Redis (prestart sidecar, ephemeral cache) ------------------------
    task "redis" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "redis_image" . ]]"
        network_mode = "host"
        ports        = ["redis"]
        args         = ["redis-server", "--port", "[[ var "redis_port" . ]]"]
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }

    # --- Init: create environment + admin user (prestart, runs once) ------
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image        = "[[ var "cli_image" . ]]"
        network_mode = "host"
        entrypoint   = ["/bin/bash", "-c"]
        args = [<<EOH
set -u
echo "Waiting for PostgreSQL on 127.0.0.1:$DB_PORT ..."
until /opt/osctrl/bin/osctrl-cli check-db; do echo "  db not ready, retrying"; sleep 3; done
if /opt/osctrl/bin/osctrl-cli --db env add --name "$ENV_NAME" --hostname "$OSCTRL_HOST"; then
  echo "Created environment $ENV_NAME"
else
  echo "Environment $ENV_NAME already exists"
fi
if /opt/osctrl/bin/osctrl-cli --db user add --admin --username "$OSCTRL_USER" --password "$OSCTRL_PASS" --environment "$ENV_NAME" --fullname "$OSCTRL_USER"; then
  echo "Created admin user $OSCTRL_USER"
else
  echo "User $OSCTRL_USER already exists"
fi
echo "osctrl bootstrap complete"
EOH
        ]
      }

      env {
        ENV_NAME    = "[[ var "env_name" . ]]"
        OSCTRL_HOST = "[[ var "osquery_host" . ]]"
        OSCTRL_USER = "[[ var "admin_user" . ]]"
        OSCTRL_PASS = "[[ var "admin_password" . ]]"
        JWT_SECRET  = "[[ var "jwt_secret" . ]]"
        DB_HOST     = "127.0.0.1"
        DB_PORT     = "[[ var "db_port" . ]]"
        DB_NAME     = "[[ var "db_name" . ]]"
        DB_USER     = "[[ var "db_user" . ]]"
        DB_PASS     = "[[ var "db_password" . ]]"
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }

    # --- osctrl-tls (main): the osquery TLS endpoint ----------------------
    task "tls" {
      driver = "docker"

      config {
        image        = "[[ var "tls_image" . ]]"
        network_mode = "host"
        ports        = ["tls"]
      }

      env {
        SERVICE_LISTENER        = "0.0.0.0"
        SERVICE_PORT            = "[[ var "tls_port" . ]]"
        SERVICE_HOST            = "0.0.0.0"
        SERVICE_AUTH            = "none"
        SERVICE_LOGGER          = "db"
        LOGGER_DB_SAME          = "true"
        SERVICE_LOG_FORMAT      = "console"
        SERVICE_POSTURE_ENABLED = "true"
        SERVICE_ALERTS_ENABLED  = "true"
        SERVICE_CONFIG_ENABLED  = "true"
        SERVICE_HEALTH_ENABLED  = "true"
        SERVICE_EVENTS_ENABLED  = "true"
        SERVICE_EVENTS_NAMESPACE = "[[ var "env_name" . ]]"
        SERVICE_TRUSTED_PROXIES = "[[ var "trusted_proxies" . ]]"
        DB_HOST                 = "127.0.0.1"
        DB_PORT                 = "[[ var "db_port" . ]]"
        DB_NAME                 = "[[ var "db_name" . ]]"
        DB_USER                 = "[[ var "db_user" . ]]"
        DB_PASS                 = "[[ var "db_password" . ]]"
        REDIS_HOST              = "127.0.0.1"
        REDIS_PORT              = "[[ var "redis_port" . ]]"
      }

      resources {
        cpu    = [[ (var "tls_resources" .).cpu ]]
        memory = [[ (var "tls_resources" .).memory ]]
      }
    }

    # --- osctrl-api (main): REST/JWT API ----------------------------------
    task "api" {
      driver = "docker"

      config {
        image        = "[[ var "api_image" . ]]"
        network_mode = "host"
        ports        = ["api"]
      }

      env {
        SERVICE_LISTENER        = "0.0.0.0"
        SERVICE_PORT            = "[[ var "api_port" . ]]"
        SERVICE_HOST            = "0.0.0.0"
        SERVICE_AUTH            = "jwt"
        JWT_SECRET              = "[[ var "jwt_secret" . ]]"
        SERVICE_LOGGER          = "db"
        SERVICE_LOG_FORMAT      = "console"
        SERVICE_POSTURE_ENABLED = "true"
        SERVICE_ALERTS_ENABLED  = "true"
        SERVICE_CONFIG_ENABLED  = "true"
        SERVICE_HEALTH_ENABLED  = "true"
        SERVICE_EVENTS_ENABLED  = "true"
        SERVICE_EVENTS_NAMESPACE = "[[ var "env_name" . ]]"
        SERVICE_TRUSTED_PROXIES = "[[ var "trusted_proxies" . ]]"
        OSQUERY_TABLES          = "/opt/osctrl/data/[[ var "osquery_version" . ]].json"
        DB_HOST                 = "127.0.0.1"
        DB_PORT                 = "[[ var "db_port" . ]]"
        DB_NAME                 = "[[ var "db_name" . ]]"
        DB_USER                 = "[[ var "db_user" . ]]"
        DB_PASS                 = "[[ var "db_password" . ]]"
        REDIS_HOST              = "127.0.0.1"
        REDIS_PORT              = "[[ var "redis_port" . ]]"
      }

      resources {
        cpu    = [[ (var "api_resources" .).cpu ]]
        memory = [[ (var "api_resources" .).memory ]]
      }
    }

    # --- osctrl-frontend (main): React admin SPA + /api proxy -------------
    # The image bakes an nginx config that listens on :80 and proxies to the
    # docker DNS name "osctrl-api". Neither works under host networking, so we
    # render our own config over the one the entrypoint symlinks in, binding
    # the chosen port and proxying /api to 127.0.0.1:<api_port>. user = "root"
    # lets the image entrypoint manage /etc/nginx/conf.d (nginx drops to the
    # nginx user for workers).
    task "frontend" {
      driver = "docker"
      user   = "root"

      config {
        image        = "[[ var "frontend_image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        volumes      = ["local/osctrl-frontend.conf:/etc/nginx/conf.d-available/osctrl-frontend.conf"]
      }

      env {
        OSCTRL_FRONTEND_TLS = "0"
      }

      template {
        destination = "local/osctrl-frontend.conf"
        data        = <<EOH
server {
    listen       [[ var "frontend_port" . ]];
    server_name  _;
    server_tokens off;

    root  /usr/share/nginx/osctrl-frontend;
    index index.html;

    location /api/ {
        proxy_pass http://127.0.0.1:[[ var "api_port" . ]];
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Connection "";
        proxy_read_timeout 120s;
        proxy_send_timeout 120s;
        # Allow large extension/carve uploads through the proxy.
        client_max_body_size 65m;
    }

    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOH
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}
