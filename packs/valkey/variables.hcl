variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "valkey"
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
  description = "The Valkey container image. Pin a tag in production."
  type        = string
  default     = "valkey/valkey:8-alpine"
}

variable "port" {
  description = "Host port Valkey listens on."
  type        = number
  default     = 6379
}

variable "password" {
  description = "Optional password (requirepass). Empty = no auth (fine on a trusted network)."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /data (AOF persistence). A fresh volume inherits the image's dir ownership (uid 999), so Valkey can write it."
  type        = string
  default     = "valkey_data"
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
    cpu    = 300
    memory = 256
  }
}
