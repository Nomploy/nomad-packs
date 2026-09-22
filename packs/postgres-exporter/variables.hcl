variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "postgres-exporter"
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
  description = "The Prometheus Postgres Exporter image. Pin a tag in production."
  type        = string
  default     = "quay.io/prometheuscommunity/postgres-exporter:latest"
}

variable "port" {
  description = "Host port for the exporter (/metrics)."
  type        = number
  default     = 9187
}

variable "data_source_name" {
  description = "Postgres DSN the exporter connects to (DATA_SOURCE_NAME). Use a read-only monitoring role in production. With host networking a co-located postgres pack is reachable on 127.0.0.1."
  type        = string
  default     = "postgresql://postgres:postgres@127.0.0.1:5432/postgres?sslmode=disable"
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
    cpu    = 200
    memory = 64
  }
}
