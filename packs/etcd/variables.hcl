variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "etcd"
}

variable "namespace" {
  description = "The Nomad namespace to deploy into."
  type        = string
  default     = "default"
}

variable "datacenters" {
  description = "The datacenters to deploy to."
  type        = list(string)
  default     = ["*"]
}

variable "image" {
  description = "The etcd container image. Pin a tag in production."
  type        = string
  default     = "quay.io/coreos/etcd:v3.5.16"
}

variable "client_port" {
  description = "Host port for the client (gRPC/HTTP) API."
  type        = number
  default     = 2379
}

variable "peer_port" {
  description = "Host port for peer communication."
  type        = number
  default     = 2380
}

variable "advertise_host" {
  description = "Host/IP advertised to clients (advertise-client-urls). 127.0.0.1 works for co-located clients; set the node IP for remote clients."
  type        = string
  default     = "127.0.0.1"
}

variable "data_volume" {
  description = "Named volume for the etcd data directory (/etcd-data)."
  type        = string
  default     = "etcd_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
