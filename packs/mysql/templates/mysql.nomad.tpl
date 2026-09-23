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
      port "db" {
        static = [[ var "port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "db"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "mysql" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["db"]
        args         = ["--port=[[ var "port" . ]]"]
        mount {
          type   = "volume"
          target = "/var/lib/mysql"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        MYSQL_DATABASE      = "[[ var "database" . ]]"
        MYSQL_USER          = "[[ var "username" . ]]"
        MYSQL_PASSWORD      = "[[ var "password" . ]]"
        MYSQL_ROOT_PASSWORD = "[[ var "root_password" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
