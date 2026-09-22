variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "cockroachdb"
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
  description = "The CockroachDB container image. Pin a tag in production."
  type        = string
  default     = "cockroachdb/cockroach:latest"
}

variable "sql_port" {
  description = "Host port for the SQL / PostgreSQL wire protocol."
  type        = number
  default     = 26257
}

variable "http_port" {
  description = "Host port for the DB Console (web UI)."
  type        = number
  default     = 8085
}

variable "data_volume" {
  description = "Named volume for the database store (/cockroach/cockroach-data)."
  type        = string
  default     = "cockroachdb_data"
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
    cpu    = 1000
    memory = 1024
  }
}
