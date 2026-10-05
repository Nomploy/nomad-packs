variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "sun-panel"
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
  description = "The Sun-Panel container image. Pin a tag in production."
  type        = string
  default     = "hslr/sun-panel:latest"
}

variable "port" {
  description = "Host port for the Sun-Panel web UI."
  type        = number
  default     = 3002
}

variable "conf_volume" {
  description = "Named volume for Sun-Panel config, database and uploads (/app/conf)."
  type        = string
  default     = "sun_panel_conf"
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
  description = "Resources for the Sun-Panel task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
