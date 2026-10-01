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
        static = [[ var "admin_port" . ]]
      }
      port "smtp" {
        static = [[ var "smtp_port" . ]]
      }
      port "submission" {
        static = [[ var "submission_port" . ]]
      }
      port "submissions" {
        static = [[ var "submissions_port" . ]]
      }
      port "imap" {
        static = [[ var "imap_port" . ]]
      }
      port "imaps" {
        static = [[ var "imaps_port" . ]]
      }
      port "sieve" {
        static = [[ var "sieve_port" . ]]
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

    task "stalwart" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "smtp", "submission", "submissions", "imap", "imaps", "sieve"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/opt/stalwart"
        }
      }

      env {
        STALWART_RECOVERY_ADMIN = "[[ var "admin_user" . ]]:[[ var "admin_password" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
