variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "dragonfly"
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
  description = "The DragonflyDB container image. Pin a tag in production."
  type        = string
  default     = "docker.dragonflydb.io/dragonflydb/dragonfly:latest"
}

variable "port" {
  description = "Host port Dragonfly listens on (Redis/Memcached-compatible)."
  type        = number
  default     = 6379
}

variable "password" {
  description = "Optional password (--requirepass). Empty = no auth (fine on a trusted network)."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Docker named volume for /data (snapshots). Dragonfly runs as root, so a fresh volume is writable. Back it up."
  type        = string
  default     = "dragonfly_data"
}

variable "constraints" {
  description = "Placement constraints — pin to one node so the local volume stays put. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources. Dragonfly is multi-threaded and memory-first — give it real memory (docs suggest 4GB+ to see its benefits)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
