variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ryot"
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
  description = "The Ryot container image. Pin a tag in production."
  type        = string
  default     = "ignisda/ryot:latest"
}

variable "port" {
  description = "Host port for the Ryot web UI."
  type        = number
  default     = 8000
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:17-alpine"
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL (loopback only)."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Ryot database user. CHANGE THIS."
  type        = string
  default     = "change-me-ryot-db"
}

variable "admin_access_token" {
  description = "Admin access token for the GraphQL API / privileged operations (SERVER_ADMIN_ACCESS_TOKEN). CHANGE THIS to a long random string."
  type        = string
  default     = "change-me-a-long-random-string"
}

variable "db_data_volume" {
  description = "Named volume for the PostgreSQL data directory (holds all your tracking data)."
  type        = string
  default     = "ryot_db"
}

variable "db_resources" {
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
