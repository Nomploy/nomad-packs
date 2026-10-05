variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "papra"
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
  description = "The Papra container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/papra-hq/papra:latest"
}

variable "port" {
  description = "Host port for the Papra web UI."
  type        = number
  default     = 1221
}

variable "app_base_url" {
  description = "Public base URL of this Papra instance. Set to your domain in production."
  type        = string
  default     = "http://localhost:1221"
}

variable "auth_secret" {
  description = "Secret used to sign auth sessions (openssl rand -hex 32). REQUIRED — CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_auth_secret_to_a_long_random_value"
}

variable "data_volume" {
  description = "Named volume for Papra's database and stored documents (/app/app-data)."
  type        = string
  default     = "papra_data"
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
  description = "Resources for the Papra task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 400
    memory = 512
  }
}
