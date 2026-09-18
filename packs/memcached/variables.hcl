variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "memcached"
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
  description = "The Memcached container image."
  type        = string
  default     = "memcached:alpine"
}

variable "port" {
  description = "Host port Memcached listens on."
  type        = number
  default     = 11211
}

variable "memory_limit" {
  description = "Max memory for the cache, in MB (memcached -m). Items are evicted (LRU) when full."
  type        = number
  default     = 256
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
  description = "The task resources. Give memory headroom above memory_limit."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 320
  }
}
