variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "suwayomi"
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
  description = "The Suwayomi container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/suwayomi/suwayomi-server:stable"
}

variable "port" {
  description = "Host port for the Suwayomi web UI. Fixed at 4567 inside the image."
  type        = number
  default     = 4567
}

variable "data_volume" {
  description = "Named volume mounted at /home/suwayomi/.local/share/Tachidesk (library, downloads and settings)."
  type        = string
  default     = "suwayomi_data"
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
