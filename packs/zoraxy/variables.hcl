variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "zoraxy"
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
  description = "The Zoraxy container image. Pin a tag in production."
  type        = string
  default     = "zoraxydocker/zoraxy:latest"
}

variable "port" {
  description = "Host port for the Zoraxy management web UI."
  type        = number
  default     = 8000
}

variable "config_volume" {
  description = "Named volume for Zoraxy configuration and certificates (/opt/zoraxy/config)."
  type        = string
  default     = "zoraxy_config"
}

variable "plugin_volume" {
  description = "Named volume for Zoraxy plugins (/opt/zoraxy/plugin)."
  type        = string
  default     = "zoraxy_plugin"
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
    cpu    = 500
    memory = 512
  }
}
