variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "yamtrack"
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
  description = "The Yamtrack container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/fuzzygrim/yamtrack:latest"
}

variable "redis_image" {
  description = "The Redis image for the bundled task queue."
  type        = string
  default     = "redis:8-alpine"
}

variable "port" {
  description = "Host port for the Yamtrack web UI."
  type        = number
  default     = 8000
}

variable "redis_port" {
  description = "Host port for the bundled Redis (loopback only)."
  type        = number
  default     = 6379
}

variable "secret" {
  description = "Secret key used to sign sessions (openssl rand -base64 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_secret_to_a_long_random_value"
}

variable "timezone" {
  description = "Container timezone."
  type        = string
  default     = "UTC"
}

variable "db_data_volume" {
  description = "Named volume for the SQLite database."
  type        = string
  default     = "yamtrack_db"
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
  description = "Resources for the Yamtrack app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}

variable "redis_resources" {
  description = "Resources for the bundled Redis task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
