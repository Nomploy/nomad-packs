variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "bytestash"
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
  description = "The ByteStash container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/jordan-dalby/bytestash:latest"
}

variable "port" {
  description = "Host port for the ByteStash web UI."
  type        = number
  default     = 5000
}

variable "jwt_secret" {
  description = "Secret used to sign auth tokens. CHANGE THIS to a long random value."
  type        = string
  default     = "change_me_to_a_long_random_jwt_secret_0000"
}

variable "allow_new_accounts" {
  description = "Allow registration of new accounts (true/false)."
  type        = string
  default     = "true"
}

variable "data_volume" {
  description = "Named volume for the SQLite database and snippets (/data/snippets)."
  type        = string
  default     = "bytestash_data"
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
    cpu    = 200
    memory = 256
  }
}
