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
      port "meili" {
        static = [[ var "meili_port" . ]]
      }
      port "chrome" {
        static = [[ var "chrome_port" . ]]
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

    task "chrome" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "chrome_image" . ]]"
        network_mode = "host"
        ports        = ["chrome"]
        args = [
          "--headless",
          "--no-sandbox",
          "--disable-gpu",
          "--disable-dev-shm-usage",
          "--remote-debugging-address=0.0.0.0",
          "--remote-debugging-port=[[ var "chrome_port" . ]]",
          "--hide-scrollbars",
        ]
      }

      resources {
        cpu    = [[ (var "chrome_resources" .).cpu ]]
        memory = [[ (var "chrome_resources" .).memory ]]
      }
    }

    task "karakeep" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
      }

      env {
        NEXTAUTH_SECRET  = "[[ var "nextauth_secret" . ]]"
        MEILI_MASTER_KEY = "[[ var "meili_master_key" . ]]"
        NEXTAUTH_URL     = "[[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
        DATA_DIR         = "/data"
        MEILI_ADDR       = "http://127.0.0.1:[[ var "meili_port" . ]]"
        BROWSER_WEB_URL  = "http://127.0.0.1:[[ var "chrome_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
