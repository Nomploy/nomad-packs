variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "metube"
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
  description = "The MeTube container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/alexta69/metube:latest"
}

variable "port" {
  description = "Host port for the MeTube web UI. The container listens on 8081."
  type        = number
  default     = 8081
}

variable "uid" {
  description = "User ID that owns downloaded files (UID)."
  type        = number
  default     = 1000
}

variable "gid" {
  description = "Group ID that owns downloaded files (GID)."
  type        = number
  default     = 1000
}

variable "downloads_volume" {
  description = "Named volume for downloaded files (/downloads)."
  type        = string
  default     = "metube_downloads"
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
  description = "Resources for the MeTube task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 256
  }
}
