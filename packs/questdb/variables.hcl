variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "questdb"
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
  description = "The QuestDB container image. Pin a tag in production."
  type        = string
  default     = "questdb/questdb:latest"
}

variable "http_port" {
  description = "Host port for the web console + REST API."
  type        = number
  default     = 9000
}

variable "pg_port" {
  description = "Host port for the PostgreSQL wire protocol."
  type        = number
  default     = 8812
}

variable "ilp_port" {
  description = "Host port for InfluxDB Line Protocol ingestion (TCP)."
  type        = number
  default     = 9009
}

variable "data_volume" {
  description = "Named volume for the QuestDB database (/var/lib/questdb)."
  type        = string
  default     = "questdb_data"
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
