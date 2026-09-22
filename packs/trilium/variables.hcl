variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "trilium"
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
  description = "The TriliumNext container image. Pin a tag in production."
  type        = string
  default     = "triliumnext/trilium:latest"
}

variable "port" {
  description = "Host port for the Trilium web UI (TRILIUM_PORT)."
  type        = number
  default     = 8102
}

variable "uid" {
  description = "UID Trilium runs as (USER_UID). The data volume is chown'd to this at startup."
  type        = number
  default     = 1000
}

variable "gid" {
  description = "GID Trilium runs as (USER_GID)."
  type        = number
  default     = 1000
}

variable "data_volume" {
  description = "Named volume for Trilium's data (document.db + config + attachments), at /home/node/trilium-data."
  type        = string
  default     = "trilium_data"
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
