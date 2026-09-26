variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "garnet"
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
  description = "The Garnet container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/microsoft/garnet:latest"
}

variable "port" {
  description = "Port for the RESP (Redis) protocol."
  type        = number
  default     = 6379
}

variable "aof" {
  description = "Enable the append-only file for durability across restarts (--aof). Disable for a pure in-memory cache."
  type        = bool
  default     = true
}

variable "data_volume" {
  description = "Named volume mounted at /data (checkpoints + append-only file)."
  type        = string
  default     = "garnet_data"
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
