variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "paradedb"
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
  description = "The ParadeDB container image. Pin a tag in production."
  type        = string
  default     = "paradedb/paradedb:latest"
}

variable "port" {
  description = "Host port for the PostgreSQL wire protocol."
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Initial database name (POSTGRES_DB)."
  type        = string
  default     = "paradedb"
}

variable "db_user" {
  description = "PostgreSQL superuser name (POSTGRES_USER)."
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "PostgreSQL superuser password (POSTGRES_PASSWORD). CHANGE THIS."
  type        = string
  default     = "change-me-paradedb"
}

variable "data_volume" {
  description = "Named volume mounted at /var/lib/postgresql/data."
  type        = string
  default     = "paradedb_data"
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
    cpu    = 500
    memory = 512
  }
}
