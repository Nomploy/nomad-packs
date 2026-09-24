variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "jellystat"
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
  description = "The Jellystat app image. Pin a tag in production."
  type        = string
  default     = "cyfershepard/jellystat:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "port" {
  description = "Host port for the Jellystat web app. The container listens on 3000."
  type        = number
  default     = 3000
}

variable "db_port" {
  description = "Host port for the co-located PostgreSQL."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Jellystat PostgreSQL user."
  type        = string
  default     = "jellystat"
}

variable "jwt_secret" {
  description = "Secret used to sign auth tokens (JWT_SECRET). CHANGE THIS — generate with: openssl rand -hex 32."
  type        = string
  default     = "change-me-to-a-random-secret"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all collected statistics."
  type        = string
  default     = "jellystat_db_data"
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
  description = "Resources for the Jellystat app task."
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
