variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "rsshub"
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
  description = "The RSSHub container image. Pin a tag in production."
  type        = string
  default     = "diygod/rsshub:latest"
}

variable "port" {
  description = "Host port for the RSSHub web UI / feeds."
  type        = number
  default     = 1200
}

variable "cache_type" {
  description = "Cache backend (CACHE_TYPE): \"memory\" (standalone, no dependencies) or \"redis\" (set REDIS_URL too). Keep \"memory\" for a single-container deploy."
  type        = string
  default     = "memory"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
