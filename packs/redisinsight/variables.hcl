variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "redisinsight"
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
  description = "The RedisInsight container image. Pin a tag in production."
  type        = string
  default     = "redis/redisinsight:latest"
}

variable "port" {
  description = "Host port for the RedisInsight web UI (RI_APP_PORT)."
  type        = number
  default     = 5540
}

variable "data_volume" {
  description = "Docker named volume for /data (saved connections, workbench history — stores DB passwords). A prestart task chowns it to uid 1000 (the app user)."
  type        = string
  default     = "redisinsight_data"
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
