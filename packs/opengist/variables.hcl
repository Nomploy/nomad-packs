variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "opengist"
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
  description = "The Opengist container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/thomiceli/opengist:1"
}

variable "port" {
  description = "Host port for the Opengist web UI (OG_HTTP_PORT)."
  type        = number
  default     = 6157
}

variable "uid" {
  description = "UID Opengist runs as. The data volume is chown'd to this at startup."
  type        = number
  default     = 1000
}

variable "data_volume" {
  description = "Named volume for the SQLite database and Git repositories (/opengist)."
  type        = string
  default     = "opengist_data"
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
    cpu    = 300
    memory = 256
  }
}
