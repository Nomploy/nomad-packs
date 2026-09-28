variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "infisical"
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
  description = "The Infisical container image. Pin a tag in production."
  type        = string
  default     = "infisical/infisical:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:14-alpine"
}

variable "redis_image" {
  description = "The Redis image for the bundled cache."
  type        = string
  default     = "redis:7-alpine"
}

variable "port" {
  description = "Host port for the Infisical web UI / API."
  type        = number
  default     = 8080
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL."
  type        = number
  default     = 5432
}

variable "redis_port" {
  description = "Host port for the bundled Redis."
  type        = number
  default     = 6379
}

variable "db_password" {
  description = "Password for the bundled PostgreSQL. CHANGE THIS."
  type        = string
  default     = "infisical_change_me"
}

variable "encryption_key" {
  description = "16-byte (32 hex chars) key for encrypting secrets at rest (openssl rand -hex 16). CHANGE THIS."
  type        = string
  default     = "00000000000000000000000000000000"
}

variable "auth_secret" {
  description = "Base64 32-byte secret for signing auth tokens (openssl rand -base64 32). CHANGE THIS."
  type        = string
  default     = "aGVsbG9fY2hhbmdlX21lX3RvX2FfcmFuZG9tX3ZhbHVlXzAwMDA="
}

variable "site_url" {
  description = "Public URL of this Infisical instance (used in links/emails)."
  type        = string
  default     = "http://localhost:8080"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data."
  type        = string
  default     = "infisical_db_data"
}

variable "redis_data_volume" {
  description = "Named volume for Redis data."
  type        = string
  default     = "infisical_redis_data"
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
  description = "Resources for the Infisical app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

variable "db_resources" {
  description = "Resources for the bundled PostgreSQL task."
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
