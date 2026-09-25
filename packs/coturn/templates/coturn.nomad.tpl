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
      port "turn" {
        static = [[ var "port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "turn"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "coturn" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["turn"]
        args = [
          "-n",
          "--no-cli",
          "--listening-port=[[ var "port" . ]]",
          "--realm=[[ var "realm" . ]]",
          "--fingerprint",
          "--lt-cred-mech",
          "--user=[[ var "turn_user" . ]]:[[ var "turn_password" . ]]",
          "--min-port=[[ var "min_port" . ]]",
          "--max-port=[[ var "max_port" . ]]",
          [[- if ne (var "external_ip" .) "" ]]
          "--external-ip=[[ var "external_ip" . ]]",
          [[- end ]]
        ]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
