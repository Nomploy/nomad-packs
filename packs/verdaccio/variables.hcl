variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "verdaccio"
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
  description = "The Verdaccio container image. Pin a tag in production."
  type        = string
  default     = "verdaccio/verdaccio:6"
}

variable "port" {
  description = "Host port for the Verdaccio registry / web UI (VERDACCIO_PORT)."
  type        = number
  default     = 4873
}

variable "uid" {
  description = "UID Verdaccio runs as (VERDACCIO_USER_UID). The storage volume is chown'd to this at startup."
  type        = number
  default     = 10001
}

variable "gid" {
  description = "GID for the storage volume (Verdaccio's default group)."
  type        = number
  default     = 65533
}

variable "storage_volume" {
  description = "Named volume for published packages and htpasswd (/verdaccio/storage)."
  type        = string
  default     = "verdaccio_storage"
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
