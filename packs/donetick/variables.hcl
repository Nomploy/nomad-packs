variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "donetick"
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
  description = "The Donetick container image. Pin a tag in production."
  type        = string
  default     = "donetick/donetick:latest"
}

variable "port" {
  description = "Host port for the Donetick web UI / API. The container listens on 2021."
  type        = number
  default     = 2021
}

variable "jwt_secret" {
  description = "Secret used to sign auth tokens (DT_JWT_SECRET). CHANGE THIS — generate with: openssl rand -hex 32."
  type        = string
  default     = "change-me-to-a-random-secret"
}

variable "data_volume" {
  description = "Named volume for Donetick data (/donetick-data): the SQLite database."
  type        = string
  default     = "donetick_data"
}

variable "config_volume" {
  description = "Named volume for Donetick config (/config)."
  type        = string
  default     = "donetick_config"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the Donetick task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
