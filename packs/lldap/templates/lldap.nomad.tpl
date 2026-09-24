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
      port "web" {
        static = [[ var "web_port" . ]]
      }
      port "ldap" {
        static = [[ var "ldap_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "web"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "lldap" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["web", "ldap"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
      }

      env {
        LLDAP_HTTP_PORT     = "[[ var "web_port" . ]]"
        LLDAP_LDAP_PORT     = "[[ var "ldap_port" . ]]"
        LLDAP_LDAP_BASE_DN  = "[[ var "base_dn" . ]]"
        LLDAP_LDAP_USER_PASS = "[[ var "admin_password" . ]]"
        LLDAP_JWT_SECRET    = "[[ var "jwt_secret" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
