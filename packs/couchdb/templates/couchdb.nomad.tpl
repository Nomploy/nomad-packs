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

    # chown the data volume so CouchDB (uid 5984) can write the databases.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 5984:5984 /opt/couchdb/data"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/opt/couchdb/data"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "couchdb" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        # Set the HTTP port (the image already binds 0.0.0.0 by default).
        volumes      = ["local/port.ini:/opt/couchdb/etc/local.d/zz-port.ini"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/opt/couchdb/data"
        }
      }

      template {
        destination = "local/port.ini"
        data        = <<EOH
[chttpd]
port = [[ var "port" . ]]
bind_address = 0.0.0.0
EOH
      }

      env {
        COUCHDB_USER     = "[[ var "admin_user" . ]]"
        COUCHDB_PASSWORD = "[[ var "admin_password" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
