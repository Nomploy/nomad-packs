variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "pinchflat"
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
  description = "The Pinchflat container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/kieraneglin/pinchflat:latest"
}

variable "port" {
  description = "Host port for the Pinchflat web UI. The container listens on 8945."
  type        = number
  default     = 8945
}

variable "tz" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
}

variable "basic_auth_username" {
  description = "Optional HTTP basic-auth username (BASIC_AUTH_USERNAME). Empty = no auth."
  type        = string
  default     = ""
}

variable "basic_auth_password" {
  description = "Optional HTTP basic-auth password (BASIC_AUTH_PASSWORD). Set together with the username."
  type        = string
  default     = ""
}

variable "config_volume" {
  description = "Named volume for Pinchflat config (/config): the SQLite database and settings."
  type        = string
  default     = "pinchflat_config"
}

variable "downloads_volume" {
  description = "Named volume for downloaded media (/downloads)."
  type        = string
  default     = "pinchflat_downloads"
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
  description = "Resources for the Pinchflat task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
