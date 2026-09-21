variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "miniflux"
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
  description = "The Miniflux container image. Pin a tag in production."
  type        = string
  default     = "miniflux/miniflux:latest"
}

variable "port" {
  description = "Host port for the Miniflux web UI / API."
  type        = number
  default     = 8100
}

variable "admin_user" {
  description = "Admin username, created on first boot."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Admin password, created on first boot. CHANGE THIS (Miniflux requires at least 6 characters)."
  type        = string
  default     = "changeme"
}

variable "base_url" {
  description = "Public base URL Miniflux is served at (e.g. https://reader.example.com/). Empty = leave unset."
  type        = string
  default     = ""
}

variable "postgres_image" {
  description = "PostgreSQL image backing Miniflux."
  type        = string
  default     = "postgres:16-alpine"
}

variable "db_port" {
  description = "Host port PostgreSQL listens on. Miniflux connects on 127.0.0.1."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Miniflux Postgres user. CHANGE THIS. (DB name and user are both \"miniflux\".)"
  type        = string
  default     = "miniflux"
}

variable "db_data_volume" {
  description = "Docker named volume for the Postgres data dir (feeds, entries, users). Back it up."
  type        = string
  default     = "miniflux_db_data"
}

variable "miniflux_resources" {
  description = "Resources for the Miniflux task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}

variable "postgres_resources" {
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

variable "constraints" {
  description = "Placement constraints — pin the job to one node so the Postgres local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}
