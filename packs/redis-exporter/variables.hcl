variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "redis-exporter"
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
  description = "The oliver006/redis_exporter image. Pin a tag in production."
  type        = string
  default     = "oliver006/redis_exporter:latest"
}

variable "port" {
  description = "Host port for the exporter (/metrics)."
  type        = number
  default     = 9121
}

variable "redis_addr" {
  description = "Address of the Redis/Valkey/Dragonfly server to scrape (REDIS_ADDR). With host networking a co-located redis pack is reachable on 127.0.0.1."
  type        = string
  default     = "redis://127.0.0.1:6379"
}

variable "redis_password" {
  description = "Password for the target server (REDIS_PASSWORD). Leave empty if auth is disabled."
  type        = string
  default     = ""
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
    cpu    = 200
    memory = 64
  }
}
