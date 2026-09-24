variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "teammapper"
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
  description = "The TeamMapper app image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/b310-digital/teammapper:main"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "port" {
  description = "Host port for the TeamMapper web app. The container listens on 3000."
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Host port for the co-located PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the TeamMapper PostgreSQL user."
  type        = string
  default     = "teammapper"
}

variable "delete_after_days" {
  description = "Delete mind maps that haven't been accessed for this many days (DELETE_AFTER_DAYS). 0 = never delete."
  type        = number
  default     = 30
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all mind maps."
  type        = string
  default     = "teammapper_db_data"
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
  description = "Resources for the TeamMapper app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "postgres_resources" {
  description = "Resources for the PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
