variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "esphome"
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
  description = "The ESPHome container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/esphome/esphome:latest"
}

variable "port" {
  description = "Host port for the ESPHome dashboard."
  type        = number
  default     = 6052
}

variable "data_volume" {
  description = "Named volume for your device YAML configs and build cache (/config)."
  type        = string
  default     = "esphome_config"
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
  description = "The task resources (compiling firmware is CPU-heavy)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
