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

  # All-in-one: MySQL starts first (prestart sidecar); Ghost reaches it on
  # 127.0.0.1 and runs its migrations on start. count stays 1 (local volumes).
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
      attempts = 5
      interval = "10m"
      delay    = "20s"
      mode     = "delay"
    }

    # chown the content volume so Ghost (uid 1000 / node) can write it.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:1000 /var/lib/ghost/content"]

        mount {
          type   = "volume"
          source = "[[ var "content_volume" . ]]"
          target = "/var/lib/ghost/content"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    # --- MySQL (prestart sidecar) -----------------------------------------
    task "mysql" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "mysql_image" . ]]"
        network_mode = "host"
        ports        = ["db"]
        args         = ["--port=[[ var "db_port" . ]]"]

        mount {
          type   = "volume"
          source = "[[ var "db_data_volume" . ]]"
          target = "/var/lib/mysql"
        }
      }

      env {
        MYSQL_DATABASE      = "ghost"
        MYSQL_USER          = "ghost"
        MYSQL_PASSWORD      = "[[ var "db_password" . ]]"
        MYSQL_ROOT_PASSWORD = "[[ var "db_root_password" . ]]"
      }

      resources {
        cpu    = [[ (var "mysql_resources" .).cpu ]]
        memory = [[ (var "mysql_resources" .).memory ]]
      }
    }

    # --- Ghost (main) -----------------------------------------------------
    task "ghost" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "content_volume" . ]]"
          target = "/var/lib/ghost/content"
        }
      }

      env {
        NODE_ENV    = "production"
        server__host = "0.0.0.0"
        server__port = "[[ var "port" . ]]"
        [[- if ne (var "url" .) "" ]]
        url         = "[[ var "url" . ]]"
        [[- else ]]
        url         = "http://localhost:[[ var "port" . ]]"
        [[- end ]]

        database__client              = "mysql"
        database__connection__host    = "127.0.0.1"
        database__connection__port    = "[[ var "db_port" . ]]"
        database__connection__user    = "ghost"
        database__connection__password = "[[ var "db_password" . ]]"
        database__connection__database = "ghost"
      }

      resources {
        cpu    = [[ (var "ghost_resources" .).cpu ]]
        memory = [[ (var "ghost_resources" .).memory ]]
      }
    }
  }
}
