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

    task "init" {
      driver = "docker"

      lifecycle {
        hook = "prestart"
      }

      config {
        image   = "busybox:stable"
        command = "sh"
        args    = ["-c", "for d in config data plugins client/plugins; do mkdir -p /mattermost/$d && chown -R [[ var "uid" . ]]:[[ var "uid" . ]] /mattermost/$d; done"]
        mount {
          type   = "volume"
          target = "/mattermost/config"
          source = "[[ var "config_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/mattermost/data"
          source = "[[ var "data_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/mattermost/plugins"
          source = "[[ var "plugins_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/mattermost/client/plugins"
          source = "[[ var "client_plugins_volume" . ]]"
        }
      }

      resources {
        cpu    = 50
        memory = 32
      }
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
        POSTGRES_DB       = "mattermost"
        POSTGRES_USER     = "mattermost"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    task "mattermost" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/mattermost/config"
          source = "[[ var "config_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/mattermost/data"
          source = "[[ var "data_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/mattermost/plugins"
          source = "[[ var "plugins_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/mattermost/client/plugins"
          source = "[[ var "client_plugins_volume" . ]]"
        }
      }

      env {
        MM_SQLSETTINGS_DRIVERNAME    = "postgres"
        MM_SQLSETTINGS_DATASOURCE    = "postgres://mattermost:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/mattermost?sslmode=disable"
        MM_SERVICESETTINGS_LISTENADDRESS = ":[[ var "port" . ]]"
        MM_SERVICESETTINGS_SITEURL   = "[[ if ne (var "site_url" .) "" ]][[ var "site_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
