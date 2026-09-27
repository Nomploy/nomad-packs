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
      port "db" {
        static = [[ var "db_port" . ]]
      }
      port "meili" {
        static = [[ var "meili_port" . ]]
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

    task "meilisearch" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "meilisearch_image" . ]]"
        network_mode = "host"
        ports        = ["meili"]

        mount {
          type   = "volume"
          source = "[[ var "meili_data_volume" . ]]"
          target = "/meili_data"
        }
      }

      env {
        MEILI_HTTP_ADDR    = "127.0.0.1:[[ var "meili_port" . ]]"
        MEILI_MASTER_KEY   = "[[ var "meili_master_key" . ]]"
        MEILI_NO_ANALYTICS = "true"
        MEILI_ENV          = "production"
      }

      resources {
        cpu    = [[ (var "meilisearch_resources" .).cpu ]]
        memory = [[ (var "meilisearch_resources" .).memory ]]
      }
    }

    task "db" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "db_image" . ]]"
        network_mode = "host"
        ports        = ["db"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/pb_data"
        }
      }

      env {
        POCKETBASE_ENCRYPTION_KEY = "[[ var "pocketbase_encryption_key" . ]]"
        MEILI_URL                 = "http://127.0.0.1:[[ var "meili_port" . ]]"
        MEILI_MASTER_KEY          = "[[ var "meili_master_key" . ]]"
        ORIGIN                    = "[[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
      }

      resources {
        cpu    = [[ (var "db_resources" .).cpu ]]
        memory = [[ (var "db_resources" .).memory ]]
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
        ORIGIN               = "[[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
        PUBLIC_POCKETBASE_URL = "[[ if ne (var "pocketbase_url" .) "" ]][[ var "pocketbase_url" . ]][[ else ]]http://localhost:[[ var "db_port" . ]][[ end ]]"
        BODY_SIZE_LIMIT      = "Infinity"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
