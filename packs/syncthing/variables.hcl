variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "syncthing"
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
  description = "The official Syncthing container image. Pin a tag in production."
  type        = string
  default     = "syncthing/syncthing:latest"
}

variable "gui_port" {
  description = "Host port for the Syncthing web GUI."
  type        = number
  default     = 8384
}

variable "sync_port" {
  description = "Host port for device-to-device sync traffic (TCP and QUIC/UDP)."
  type        = number
  default     = 22000
}

variable "uid" {
  description = "UID Syncthing runs as (PUID). The data volume is chown'd to this at startup."
  type        = number
  default     = 1000
}

variable "gid" {
  description = "GID Syncthing runs as (PGID)."
  type        = number
  default     = 1000
}

variable "data_volume" {
  description = "Named volume for Syncthing's config, keys, and default sync folder (/var/syncthing)."
  type        = string
  default     = "syncthing_data"
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
    cpu    = 500
    memory = 256
  }
}
