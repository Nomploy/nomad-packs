variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "statping"
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
  description = "The Statping-ng container image. Pin a tag in production."
  type        = string
  default     = "adamboutcher/statping-ng:latest"
}

variable "port" {
  description = "Host port for the Statping-ng web UI (PORT)."
  type        = number
  default     = 8104
}

variable "admin_user" {
  description = "Initial admin username (ADMIN_USER)."
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Initial admin password (ADMIN_PASSWORD). CHANGE THIS."
  type        = string
  default     = "changeme-please"
}

variable "data_volume" {
  description = "Named volume for config, SQLite database, and assets (/app)."
  type        = string
  default     = "statping_data"
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
