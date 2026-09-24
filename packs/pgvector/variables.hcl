variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "pgvector"
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
  description = "The pgvector PostgreSQL image (postgres + pgvector). Match the tag to your Postgres major version. Pin a tag in production."
  type        = string
  default     = "pgvector/pgvector:pg16"
}

variable "port" {
  description = "Host port for PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Initial database created on first boot (POSTGRES_DB)."
  type        = string
  default     = "app"
}

variable "db_user" {
  description = "PostgreSQL superuser (POSTGRES_USER)."
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "PostgreSQL password (POSTGRES_PASSWORD). CHANGE THIS."
  type        = string
  default     = "change-me-please"
}

variable "data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all databases and vectors."
  type        = string
  default     = "pgvector_data"
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
  description = "Resources for the PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
