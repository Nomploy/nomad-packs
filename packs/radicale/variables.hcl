variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "radicale"
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
  description = "The Radicale container image. Pin a tag in production."
  type        = string
  default     = "rockstorm/radicale:latest"
}

variable "port" {
  description = "Host port for the Radicale CalDAV/CardDAV server."
  type        = number
  default     = 5232
}

variable "username" {
  description = "The user allowed to sync (htpasswd)."
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Password for the user (stored plaintext in the users file — switch to bcrypt for production). CHANGE THIS."
  type        = string
  default     = "changeme-please"
}

variable "uid" {
  description = "UID Radicale runs as. The data volume is chown'd to this at startup."
  type        = number
  default     = 2999
}

variable "data_volume" {
  description = "Named volume for stored calendars and contacts (/var/lib/radicale/collections)."
  type        = string
  default     = "radicale_data"
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
