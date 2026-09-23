variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "mumble"
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
  description = "The Mumble server container image. Pin a tag in production."
  type        = string
  default     = "mumblevoip/mumble-server:latest"
}

variable "port" {
  description = "Host port for the Mumble server (TCP and UDP)."
  type        = number
  default     = 64738
}

variable "superuser_password" {
  description = "Password for the SuperUser admin account (MUMBLE_SUPERUSER_PASSWORD). CHANGE THIS."
  type        = string
  default     = "changeme-please"
}

variable "uid" {
  description = "UID the server runs as. The data volume is chown'd to this at startup."
  type        = number
  default     = 1000
}

variable "data_volume" {
  description = "Named volume for the server database and config (/data)."
  type        = string
  default     = "mumble_data"
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
    memory = 128
  }
}
