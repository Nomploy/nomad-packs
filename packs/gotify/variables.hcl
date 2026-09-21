variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "gotify"
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
  description = "The Gotify server container image. Pin a tag in production."
  type        = string
  default     = "gotify/server:latest"
}

variable "port" {
  description = "Host port for the Gotify web UI / API (GOTIFY_SERVER_PORT)."
  type        = number
  default     = 8099
}

variable "admin_user" {
  description = "Initial admin username, created on first boot."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Initial admin password. CHANGE THIS. Only applied on first boot (empty data volume)."
  type        = string
  default     = "admin"
}

variable "data_volume" {
  description = "Docker named volume for /app/data (SQLite database, uploaded images, plugins). Gotify runs as root, so a fresh volume is writable. Back it up."
  type        = string
  default     = "gotify_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
    cpu    = 200
    memory = 128
  }
}
