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
      port "client" {
        static = [[ var "client_port" . ]]
      }
      port "peer" {
        static = [[ var "peer_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "client"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "etcd" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["client", "peer"]
        args = [
          "etcd",
          "--name=s1",
          "--data-dir=/etcd-data",
          "--listen-client-urls=http://0.0.0.0:[[ var "client_port" . ]]",
          "--advertise-client-urls=http://[[ var "advertise_host" . ]]:[[ var "client_port" . ]]",
          "--listen-peer-urls=http://0.0.0.0:[[ var "peer_port" . ]]",
          "--initial-advertise-peer-urls=http://[[ var "advertise_host" . ]]:[[ var "peer_port" . ]]",
          "--initial-cluster=s1=http://[[ var "advertise_host" . ]]:[[ var "peer_port" . ]]",
          "--initial-cluster-state=new",
        ]
        mount {
          type   = "volume"
          target = "/etcd-data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
