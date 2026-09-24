variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "dolt"
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
  description = "The Dolt SQL server image. Pin a tag in production."
  type        = string
  default     = "dolthub/dolt-sql-server:latest"
}

variable "port" {
  description = "Host port for the MySQL-compatible SQL server."
  type        = number
  default     = 3306
}

variable "root_password" {
  description = "Password for the root user (DOLT_ROOT_PASSWORD). CHANGE THIS."
  type        = string
  default     = "change-me-please"
}

variable "data_volume" {
  description = "Named volume for Dolt data (/var/lib/dolt): all databases, branches, and history."
  type        = string
  default     = "dolt_data"
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
  description = "Resources for the Dolt task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
