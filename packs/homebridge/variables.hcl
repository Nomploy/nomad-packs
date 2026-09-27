variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "homebridge"
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
  description = "The Homebridge container image. Pin a tag in production."
  type        = string
  default     = "homebridge/homebridge:latest"
}

variable "port" {
  description = "Host port for the Homebridge Config UI X."
  type        = number
  default     = 8581
}

variable "timezone" {
  description = "Timezone for the container (e.g. Europe/Bratislava)."
  type        = string
  default     = "UTC"
}

variable "enable_avahi" {
  description = "Enable the built-in Avahi mDNS daemon for HomeKit discovery (1 = enabled, 0 = disabled)."
  type        = string
  default     = "1"
}

variable "config_volume" {
  description = "Named volume for Homebridge config, plugins and persisted state (/homebridge)."
  type        = string
  default     = "homebridge_config"
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
