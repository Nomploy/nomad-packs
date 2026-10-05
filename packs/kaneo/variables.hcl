variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "kaneo"
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
  description = "The Kaneo container image (serves both the API and the web UI). Pin a tag in production."
  type        = string
  default     = "ghcr.io/usekaneo/kaneo:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "port" {
  description = "Host port for the Kaneo web UI / API."
  type        = number
  default     = 5173
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL (loopback only)."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the bundled PostgreSQL. CHANGE THIS."
  type        = string
  default     = "kaneo_change_me"
}

variable "auth_secret" {
  description = "Secret used to sign auth sessions (openssl rand -hex 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "0000000000000000000000000000000000000000000000000000000000000000"
}

variable "client_url" {
  description = "Public URL of this Kaneo instance (used to build API/client links). Set to your domain in production."
  type        = string
  default     = "http://localhost:5173"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data."
  type        = string
  default     = "kaneo_db_data"
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
  description = "Resources for the Kaneo app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "db_resources" {
  description = "Resources for the bundled PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
