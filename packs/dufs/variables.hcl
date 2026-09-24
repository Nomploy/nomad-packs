variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "dufs"
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
  description = "The Dufs container image. Pin a tag in production."
  type        = string
  default     = "sigoden/dufs:latest"
}

variable "port" {
  description = "Host port for the file server."
  type        = number
  default     = 5001
}

variable "allow_all" {
  description = "Allow uploads, deletes, renames, and directory creation (dufs -A). Default false = read-only serving."
  type        = bool
  default     = false
}

variable "auth" {
  description = "Optional access-control rule (dufs -a), e.g. \"user:pass@/:rw\". Empty = no auth (anyone can access)."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume for the served files (/data)."
  type        = string
  default     = "dufs_data"
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
  description = "Resources for the Dufs task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
