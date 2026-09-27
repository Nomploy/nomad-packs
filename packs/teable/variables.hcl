variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "teable"
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
  description = "The Teable container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/teableio/teable:latest"
}

variable "port" {
  description = "Host port for the Teable web UI."
  type        = number
  default     = 3000
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16"
}

variable "redis_image" {
  description = "The Redis image for the bundled cache."
  type        = string
  default     = "redis:7"
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL (loopback only)."
  type        = number
  default     = 5432
}

variable "redis_port" {
  description = "Host port for the bundled Redis (loopback only)."
  type        = number
  default     = 6379
}

variable "db_password" {
  description = "Password for the Teable database user. CHANGE THIS."
  type        = string
  default     = "change-me-teable-db"
}

variable "redis_password" {
  description = "Password for the bundled Redis. CHANGE THIS."
  type        = string
  default     = "change-me-teable-redis"
}

variable "secret_key" {
  description = "Secret used to sign tokens/sessions (SECRET_KEY). CHANGE THIS. Generate with: openssl rand -base64 32."
  type        = string
  default     = "change-me-openssl-rand-base64-32"
}

variable "base_url" {
  description = "Public URL Teable is reached at (PUBLIC_ORIGIN). Empty = http://localhost:<port>. Set to your real host/domain."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume mounted at /app/.assets — uploaded attachments."
  type        = string
  default     = "teable_data"
}

variable "db_data_volume" {
  description = "Named volume for the PostgreSQL data directory (holds all Teable data)."
  type        = string
  default     = "teable_db"
}

variable "db_resources" {
  description = "Resources for the PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 400
    memory = 512
  }
}

variable "redis_resources" {
  description = "Resources for the Redis task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
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
  description = "Resources for the Teable app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
