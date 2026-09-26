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
      port "agent" {
        static = [[ var "agent_port" . ]]
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

    # chown the home volume so Jenkins (uid 1000) can write it.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:1000 /var/jenkins_home"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/jenkins_home"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "jenkins" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "agent"]
        mount {
          type   = "volume"
          target = "/var/jenkins_home"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        JENKINS_OPTS     = "--httpPort=[[ var "port" . ]]"
        JENKINS_SLAVE_AGENT_PORT = "[[ var "agent_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
