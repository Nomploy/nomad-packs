variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "whodb"
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
  description = "The WhoDB container image. Pin a tag in production."
  type        = string
  default     = "clidey/whodb:latest"
}

variable "port" {
  description = "Host port for the WhoDB web UI."
  type        = number
  default     = 8080
}

variable "encryption_key" {
  description = "64-char hex key to encrypt stored login sessions (openssl rand -hex 32). CHANGE THIS."
  type        = string
  default     = "0000000000000000000000000000000000000000000000000000000000000000"
}

variable "data_volume" {
  description = "Named volume for persisted (encrypted) login sessions (/data)."
  type        = string
  default     = "whodb_data"
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
