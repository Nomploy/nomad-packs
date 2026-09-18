variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "umami"
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
  description = "The Umami container image (PostgreSQL build). Pin a tag in production."
  type        = string
  default     = "ghcr.io/umami-software/umami:postgresql-latest"
}

variable "port" {
  description = "Host port for the Umami web UI / tracking endpoint. Default 3005 to avoid the panel (:3000), grafana (:3001), gitea (:3002), metabase (:3003)."
  type        = number
  default     = 3005
}

variable "app_secret" {
  description = "Secret used to sign auth tokens. Set a random string in production (keep it stable). Empty = Umami derives one."
  type        = string
  default     = ""
}

variable "postgres_image" {
  description = "PostgreSQL image backing Umami."
  type        = string
  default     = "postgres:16-alpine"
}

variable "db_port" {
  description = "Host port PostgreSQL listens on. Umami connects on 127.0.0.1."
  type        = number
  default     = 5432
}

variable "db_password" {
  description = "Password for the Umami database user. CHANGE THIS. (DB name and user are both \"umami\".)"
  type        = string
  default     = "umami"
}

variable "db_data_volume" {
  description = "Docker named volume for the Postgres data dir — all analytics data. Back it up. A fresh volume inherits the image's data-dir ownership."
  type        = string
  default     = "umami_db_data"
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

variable "umami_resources" {
  description = "Resources for the Umami task."
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
    cpu    = 500
    memory = 512
  }
}
