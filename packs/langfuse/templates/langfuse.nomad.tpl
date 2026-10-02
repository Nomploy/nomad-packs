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

  group "[[ var "job_name" . ]]" {
    count = 1

    network {
      mode = "host"
      port "http" {
        static = [[ var "port" . ]]
      }
      port "worker" {
        static = [[ var "worker_port" . ]]
      }
      port "db" {
        static = [[ var "db_port" . ]]
      }
      port "ch_http" {
        static = [[ var "clickhouse_http_port" . ]]
      }
      port "ch_native" {
        static = [[ var "clickhouse_native_port" . ]]
      }
      port "redis" {
        static = [[ var "redis_port" . ]]
      }
      port "minio" {
        static = [[ var "minio_port" . ]]
      }
      port "minio_console" {
        static = [[ var "minio_console_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "http"
    }

    restart {
      attempts = 5
      interval = "10m"
      delay    = "20s"
      mode     = "delay"
    }

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
        POSTGRES_DB       = "postgres"
        POSTGRES_USER     = "postgres"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "db_resources" .).cpu ]]
        memory = [[ (var "db_resources" .).memory ]]
      }
    }

    task "clickhouse" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "clickhouse_image" . ]]"
        network_mode = "host"
        ports        = ["ch_http", "ch_native"]

        ulimit {
          nofile = "262144:262144"
        }

        mount {
          type   = "volume"
          source = "[[ var "clickhouse_data_volume" . ]]"
          target = "/var/lib/clickhouse"
        }
      }

      env {
        CLICKHOUSE_USER                        = "clickhouse"
        CLICKHOUSE_PASSWORD                    = "[[ var "clickhouse_password" . ]]"
        CLICKHOUSE_DB                          = "default"
        CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT   = "1"
      }

      resources {
        cpu    = [[ (var "clickhouse_resources" .).cpu ]]
        memory = [[ (var "clickhouse_resources" .).memory ]]
      }
    }

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
        args = [
          "redis-server",
          "--port", "[[ var "redis_port" . ]]",
          "--requirepass", "[[ var "redis_password" . ]]",
          "--maxmemory-policy", "noeviction",
        ]
      }

      resources {
        cpu    = [[ (var "redis_resources" .).cpu ]]
        memory = [[ (var "redis_resources" .).memory ]]
      }
    }

    task "minio" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "minio_image" . ]]"
        network_mode = "host"
        ports        = ["minio", "minio_console"]
        entrypoint   = ["sh", "-c"]
        args         = ["mkdir -p /data/langfuse && exec minio server --address \":[[ var "minio_port" . ]]\" --console-address \":[[ var "minio_console_port" . ]]\" /data"]

        mount {
          type   = "volume"
          source = "[[ var "minio_data_volume" . ]]"
          target = "/data"
        }
      }

      env {
        MINIO_ROOT_USER     = "minio"
        MINIO_ROOT_PASSWORD = "[[ var "minio_root_password" . ]]"
      }

      resources {
        cpu    = [[ (var "minio_resources" .).cpu ]]
        memory = [[ (var "minio_resources" .).memory ]]
      }
    }

    task "worker" {
      driver = "docker"

      config {
        image        = "[[ var "worker_image" . ]]"
        network_mode = "host"
        ports        = ["worker"]
      }

      env {
        PORT                                        = "[[ var "worker_port" . ]]"
        DATABASE_URL                                = "postgresql://postgres:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/postgres"
        SALT                                        = "[[ var "salt" . ]]"
        ENCRYPTION_KEY                              = "[[ var "encryption_key" . ]]"
        TELEMETRY_ENABLED                           = "[[ var "telemetry_enabled" . ]]"
        CLICKHOUSE_MIGRATION_URL                    = "clickhouse://127.0.0.1:[[ var "clickhouse_native_port" . ]]"
        CLICKHOUSE_URL                              = "http://127.0.0.1:[[ var "clickhouse_http_port" . ]]"
        CLICKHOUSE_USER                             = "clickhouse"
        CLICKHOUSE_PASSWORD                         = "[[ var "clickhouse_password" . ]]"
        CLICKHOUSE_CLUSTER_ENABLED                  = "false"
        REDIS_HOST                                  = "127.0.0.1"
        REDIS_PORT                                  = "[[ var "redis_port" . ]]"
        REDIS_AUTH                                  = "[[ var "redis_password" . ]]"
        REDIS_TLS_ENABLED                           = "false"
        LANGFUSE_S3_EVENT_UPLOAD_BUCKET             = "langfuse"
        LANGFUSE_S3_EVENT_UPLOAD_REGION             = "auto"
        LANGFUSE_S3_EVENT_UPLOAD_ACCESS_KEY_ID      = "minio"
        LANGFUSE_S3_EVENT_UPLOAD_SECRET_ACCESS_KEY  = "[[ var "minio_root_password" . ]]"
        LANGFUSE_S3_EVENT_UPLOAD_ENDPOINT           = "http://127.0.0.1:[[ var "minio_port" . ]]"
        LANGFUSE_S3_EVENT_UPLOAD_FORCE_PATH_STYLE   = "true"
        LANGFUSE_S3_EVENT_UPLOAD_PREFIX             = "events/"
        LANGFUSE_S3_MEDIA_UPLOAD_BUCKET             = "langfuse"
        LANGFUSE_S3_MEDIA_UPLOAD_REGION             = "auto"
        LANGFUSE_S3_MEDIA_UPLOAD_ACCESS_KEY_ID      = "minio"
        LANGFUSE_S3_MEDIA_UPLOAD_SECRET_ACCESS_KEY  = "[[ var "minio_root_password" . ]]"
        LANGFUSE_S3_MEDIA_UPLOAD_ENDPOINT           = "http://127.0.0.1:[[ var "minio_port" . ]]"
        LANGFUSE_S3_MEDIA_UPLOAD_FORCE_PATH_STYLE   = "true"
        LANGFUSE_S3_MEDIA_UPLOAD_PREFIX             = "media/"
      }

      resources {
        cpu    = [[ (var "worker_resources" .).cpu ]]
        memory = [[ (var "worker_resources" .).memory ]]
      }
    }

    task "web" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
      }

      env {
        PORT                                          = "[[ var "port" . ]]"
        NEXTAUTH_URL                                  = "[[ var "nextauth_url" . ]]"
        NEXTAUTH_SECRET                               = "[[ var "nextauth_secret" . ]]"
        DATABASE_URL                                  = "postgresql://postgres:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/postgres"
        SALT                                          = "[[ var "salt" . ]]"
        ENCRYPTION_KEY                                = "[[ var "encryption_key" . ]]"
        TELEMETRY_ENABLED                             = "[[ var "telemetry_enabled" . ]]"
        CLICKHOUSE_MIGRATION_URL                      = "clickhouse://127.0.0.1:[[ var "clickhouse_native_port" . ]]"
        CLICKHOUSE_URL                                = "http://127.0.0.1:[[ var "clickhouse_http_port" . ]]"
        CLICKHOUSE_USER                               = "clickhouse"
        CLICKHOUSE_PASSWORD                           = "[[ var "clickhouse_password" . ]]"
        CLICKHOUSE_CLUSTER_ENABLED                    = "false"
        REDIS_HOST                                    = "127.0.0.1"
        REDIS_PORT                                    = "[[ var "redis_port" . ]]"
        REDIS_AUTH                                    = "[[ var "redis_password" . ]]"
        REDIS_TLS_ENABLED                             = "false"
        LANGFUSE_S3_EVENT_UPLOAD_BUCKET               = "langfuse"
        LANGFUSE_S3_EVENT_UPLOAD_REGION               = "auto"
        LANGFUSE_S3_EVENT_UPLOAD_ACCESS_KEY_ID        = "minio"
        LANGFUSE_S3_EVENT_UPLOAD_SECRET_ACCESS_KEY    = "[[ var "minio_root_password" . ]]"
        LANGFUSE_S3_EVENT_UPLOAD_ENDPOINT             = "http://127.0.0.1:[[ var "minio_port" . ]]"
        LANGFUSE_S3_EVENT_UPLOAD_FORCE_PATH_STYLE     = "true"
        LANGFUSE_S3_EVENT_UPLOAD_PREFIX               = "events/"
        LANGFUSE_S3_MEDIA_UPLOAD_BUCKET               = "langfuse"
        LANGFUSE_S3_MEDIA_UPLOAD_REGION               = "auto"
        LANGFUSE_S3_MEDIA_UPLOAD_ACCESS_KEY_ID        = "minio"
        LANGFUSE_S3_MEDIA_UPLOAD_SECRET_ACCESS_KEY    = "[[ var "minio_root_password" . ]]"
        LANGFUSE_S3_MEDIA_UPLOAD_ENDPOINT             = "[[ var "s3_public_endpoint" . ]]"
        LANGFUSE_S3_MEDIA_UPLOAD_INTERNAL_ENDPOINT    = "http://127.0.0.1:[[ var "minio_port" . ]]"
        LANGFUSE_S3_MEDIA_UPLOAD_FORCE_PATH_STYLE     = "true"
        LANGFUSE_S3_MEDIA_UPLOAD_PREFIX               = "media/"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
