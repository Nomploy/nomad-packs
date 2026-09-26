variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "tempo"
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
  description = "The Grafana Tempo container image. Pin a tag in production."
  type        = string
  default     = "grafana/tempo:latest"
}

variable "port" {
  description = "HTTP port for the Tempo API / query frontend (server.http_listen_port)."
  type        = number
  default     = 3200
}

variable "otlp_grpc_port" {
  description = "OTLP gRPC ingest port."
  type        = number
  default     = 4317
}

variable "otlp_http_port" {
  description = "OTLP HTTP ingest port."
  type        = number
  default     = 4318
}

variable "block_retention" {
  description = "How long to keep trace blocks before compaction removes them."
  type        = string
  default     = "336h"
}

variable "data_volume" {
  description = "Named volume mounted at /var/tempo (WAL + trace blocks)."
  type        = string
  default     = "tempo_data"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
