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

    task "postgrest" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
      }

      env {
        PGRST_DB_URI       = "[[ var "db_uri" . ]]"
        PGRST_DB_SCHEMAS   = "[[ var "db_schema" . ]]"
        PGRST_DB_ANON_ROLE = "[[ var "db_anon_role" . ]]"
        PGRST_SERVER_HOST  = "0.0.0.0"
        PGRST_SERVER_PORT  = "[[ var "port" . ]]"
        [[- if ne (var "jwt_secret" .) "" ]]
        PGRST_JWT_SECRET   = "[[ var "jwt_secret" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
