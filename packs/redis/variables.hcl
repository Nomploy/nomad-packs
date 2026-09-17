variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "redis"
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
  description = "The Redis container image."
  type        = string
  default     = "redis:7-alpine"
}

variable "port" {
  description = "Host port Redis listens on (host networking). Pick a free port on the target node."
  type        = number
  default     = 6379
}

variable "count" {
  description = "Number of instances (keep at 1 — local-disk AOF, no built-in clustering here)."
  type        = number
  default     = 1
}

variable "password" {
  description = "Optional requirepass password. Empty = no auth (only safe on a private/overlay network)."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /data, so the AOF/RDB survives restarts and reschedules."
  type        = string
  default     = "redis_data"
}

variable "constraints" {
  description = "Placement constraints — e.g. pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
