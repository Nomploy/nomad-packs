variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "kutt"
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
  description = "The Kutt container image. Pin a tag in production."
  type        = string
  default     = "kutt/kutt:latest"
}

variable "port" {
  description = "Host port for the Kutt web UI."
  type        = number
  default     = 3000
}

variable "default_domain" {
  description = "The domain (host:port) that generated short links use."
  type        = string
  default     = "localhost:3000"
}

variable "site_name" {
  description = "Display name of the instance."
  type        = string
  default     = "Kutt"
}

variable "jwt_secret" {
  description = "Secret used to sign auth tokens. CHANGE THIS to a long random value."
  type        = string
  default     = "change_me_to_a_long_random_jwt_secret_0000"
}

variable "data_volume" {
  description = "Named volume for the SQLite database (/var/lib/kutt)."
  type        = string
  default     = "kutt_data"
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
