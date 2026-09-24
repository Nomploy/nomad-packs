variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "maloja"
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
  description = "The Maloja container image. Pin a tag in production."
  type        = string
  default     = "krateng/maloja:latest"
}

variable "port" {
  description = "Host port for the Maloja web UI / API. The container listens on 42010."
  type        = number
  default     = 42010
}

variable "force_password" {
  description = "Admin password set on first boot (MALOJA_FORCE_PASSWORD). CHANGE THIS."
  type        = string
  default     = "change-me-please"
}

variable "data_volume" {
  description = "Named volume for Maloja data (/mljdata): the scrobble database, settings, and API keys."
  type        = string
  default     = "maloja_data"
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
  description = "Resources for the Maloja task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
