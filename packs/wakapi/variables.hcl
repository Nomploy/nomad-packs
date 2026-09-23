variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "wakapi"
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
  description = "The Wakapi container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/muety/wakapi:latest"
}

variable "port" {
  description = "Host port for the Wakapi web UI / API (WAKAPI_PORT)."
  type        = number
  default     = 3016
}

variable "password_salt" {
  description = "Secret salt for hashing passwords (WAKAPI_PASSWORD_SALT). Set a long random value."
  type        = string
  default     = "change-me-to-a-long-random-salt"
}

variable "uid" {
  description = "UID Wakapi runs as. The data volume is chown'd to this at startup."
  type        = number
  default     = 1000
}

variable "data_volume" {
  description = "Named volume for the SQLite database (/data)."
  type        = string
  default     = "wakapi_data"
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
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
