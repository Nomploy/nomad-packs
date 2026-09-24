variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "healthchecks"
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
  description = "The Healthchecks container image. Pin a tag in production."
  type        = string
  default     = "healthchecks/healthchecks:latest"
}

variable "port" {
  description = "Host port for the Healthchecks web UI. The container listens on 8000."
  type        = number
  default     = 8000
}

variable "site_root" {
  description = "Public base URL Healthchecks is served at (SITE_ROOT). Ping URLs shown in the UI use this. Empty = http://localhost:<port>."
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "Django secret key (SECRET_KEY). CHANGE THIS — generate with: openssl rand -hex 32."
  type        = string
  default     = "change-me-to-a-random-secret"
}

variable "superuser_email" {
  description = "Initial admin email (SUPERUSER_EMAIL), created on first boot."
  type        = string
  default     = "admin@nomploy.local"
}

variable "superuser_password" {
  description = "Initial admin password (SUPERUSER_PASSWORD). CHANGE THIS."
  type        = string
  default     = "change-me-please"
}

variable "data_volume" {
  description = "Named volume for the SQLite database (/data, holds hc.sqlite)."
  type        = string
  default     = "healthchecks_data"
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
  description = "Resources for the Healthchecks task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
