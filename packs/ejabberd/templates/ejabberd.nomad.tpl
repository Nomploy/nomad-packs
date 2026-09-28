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
      port "c2s" {
        static = [[ var "c2s_port" . ]]
      }
      port "s2s" {
        static = [[ var "s2s_port" . ]]
      }
      port "admin" {
        static = [[ var "admin_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "c2s"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "ejabberd" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["c2s", "s2s", "admin"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/home/ejabberd/database"
        }
      }

      env {
        EJABBERD_MACRO_HOST  = "[[ var "xmpp_domain" . ]]"
        EJABBERD_MACRO_ADMIN = "[[ var "admin_user" . ]]@[[ var "xmpp_domain" . ]]"
        CTL_ON_CREATE        = "register [[ var "admin_user" . ]] [[ var "xmpp_domain" . ]] [[ var "admin_password" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
