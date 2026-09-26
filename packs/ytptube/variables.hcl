variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ytptube"
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
  description = "The YTPTube container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/arabcoders/ytptube:latest"
}

variable "port" {
  description = "Host port for the YTPTube web UI."
  type        = number
  default     = 8081
}

variable "data_volume" {
  description = "Named volume mounted at /config (settings, presets, queue database)."
  type        = string
  default     = "ytptube_data"
}

variable "downloads_volume" {
  description = "Named volume mounted at /downloads — downloaded media (files + tmp)."
  type        = string
  default     = "ytptube_downloads"
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
