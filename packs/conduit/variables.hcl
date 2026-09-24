variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "conduit"
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
  description = "The Conduit container image. Pin a tag in production."
  type        = string
  default     = "matrixconduit/matrix-conduit:latest"
}

variable "port" {
  description = "Host port for the Matrix client/federation API (CONDUIT_PORT)."
  type        = number
  default     = 6167
}

variable "server_name" {
  description = "The Matrix server name / domain (CONDUIT_SERVER_NAME). This becomes part of every user id (@user:<server_name>) and CANNOT be changed later. Set it before deploying."
  type        = string
  default     = "matrix.example.com"
}

variable "registration_token" {
  description = "Token required to register new accounts (CONDUIT_REGISTRATION_TOKEN). Share it with people you want to let sign up. CHANGE THIS."
  type        = string
  default     = "change-me-registration-token"
}

variable "allow_federation" {
  description = "Federate with other Matrix servers (CONDUIT_ALLOW_FEDERATION)."
  type        = bool
  default     = true
}

variable "data_volume" {
  description = "Named volume for the Conduit database (/var/lib/matrix-conduit). Holds all messages, rooms, and keys."
  type        = string
  default     = "conduit_data"
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
  description = "Resources for the Conduit task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
