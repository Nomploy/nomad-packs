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

    task "neko" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        shm_size     = [[ var "shm_size" . ]]
      }

      env {
        NEKO_SERVER_BIND                      = "0.0.0.0:[[ var "port" . ]]"
        NEKO_DESKTOP_SCREEN                   = "[[ var "screen" . ]]"
        NEKO_MEMBER_MULTIUSER_USER_PASSWORD   = "[[ var "user_password" . ]]"
        NEKO_MEMBER_MULTIUSER_ADMIN_PASSWORD  = "[[ var "admin_password" . ]]"
        NEKO_WEBRTC_EPR                       = "[[ var "webrtc_epr" . ]]"
        NEKO_WEBRTC_ICELITE                   = "true"
        [[- if ne (var "nat1to1_ip" .) "" ]]
        NEKO_WEBRTC_NAT1TO1                   = "[[ var "nat1to1_ip" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
