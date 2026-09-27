variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "kener"
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
  description = "The Kener container image. Pin a tag in production."
  type        = string
  default     = "rajnandan1/kener:latest"
}

variable "redis_image" {
  description = "The Redis image for the bundled queue/cache backend."
  type        = string
  default     = "redis:7-alpine"
}

variable "port" {
  description = "Host port for the Kener web UI."
  type        = number
  default     = 3000
}

variable "redis_port" {
  description = "Host port for the bundled Redis."
  type        = number
  default     = 6379
}

variable "origin" {
  description = "Public URL of this Kener instance (required for CSRF protection), e.g. https://status.example.com."
  type        = string
  default     = "http://localhost:3000"
}

variable "secret_key" {
  description = "KENER_SECRET_KEY used to sign sessions. CHANGE THIS to a long random value."
  type        = string
  default     = "change_me_to_a_long_random_secret_key_at_least_32_chars_0000000000"
}

variable "data_volume" {
  description = "Named volume for the Kener SQLite database (/app/database)."
  type        = string
  default     = "kener_data"
}

variable "redis_data_volume" {
  description = "Named volume for Redis data."
  type        = string
  default     = "kener_redis_data"
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
  description = "Resources for the Kener app task."
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
