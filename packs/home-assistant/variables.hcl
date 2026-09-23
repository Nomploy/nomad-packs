variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "home-assistant"
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
  description = "The Home Assistant container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/home-assistant/home-assistant:stable"
}

variable "port" {
  description = "Host port for the Home Assistant web UI. Home Assistant listens on 8123 by default; to change it, set http.server_port in configuration.yaml after first boot and update this to match."
  type        = number
  default     = 8123
}

variable "data_volume" {
  description = "Named volume for Home Assistant config, database, and integrations (/config)."
  type        = string
  default     = "home_assistant_config"
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
    cpu    = 1000
    memory = 1024
  }
}
