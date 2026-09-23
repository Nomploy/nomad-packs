variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "cefiro"
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
  description = "The Cefiro app image. Pin a version/sha in production."
  type        = string
  default     = "ghcr.io/pipozzz/cefiro:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database (Cefiro targets PostgreSQL 17)."
  type        = string
  default     = "postgres:17-alpine"
}

variable "redis_image" {
  description = "The Redis image for real-time events and job queues."
  type        = string
  default     = "redis:8.4.0"
}

variable "obscura_image" {
  description = "The Obscura page-renderer image used for URL recipe imports."
  type        = string
  default     = "norishapp/obscura:0.2.0-norish.1"
}

variable "port" {
  description = "Host port for the Cefiro web app (PORT)."
  type        = number
  default     = 3021
}

variable "db_port" {
  description = "Host port for the co-located PostgreSQL."
  type        = number
  default     = 5432
}

variable "redis_port" {
  description = "Host port for the co-located Redis."
  type        = number
  default     = 6379
}

variable "obscura_port" {
  description = "Host port for the Obscura CDP endpoint."
  type        = number
  default     = 9222
}

variable "db_password" {
  description = "Password for the Cefiro PostgreSQL user."
  type        = string
  default     = "cefiro"
}

variable "master_key" {
  description = "Encryption master key (MASTER_KEY). CHANGE THIS and keep it STABLE — it derives all encryption keys, so changing it later invalidates encrypted data. Generate with: openssl rand -base64 32."
  type        = string
  default     = "change-me-openssl-rand-base64-32"
}

variable "base_url" {
  description = "Public URL Cefiro is reachable at (AUTH_URL). Empty = http://localhost:<port>. Set this to your real host/domain."
  type        = string
  default     = ""
}

variable "password_auth_enabled" {
  description = "Enable email/password auth so you can create the first admin (PASSWORD_AUTH_ENABLED). Configure OIDC/OAuth later in Settings."
  type        = bool
  default     = true
}

variable "uploads_volume" {
  description = "Named volume for uploaded images/videos (/app/uploads). Not needed if you switch STORAGE_DRIVER to s3."
  type        = string
  default     = "cefiro_uploads"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all recipes."
  type        = string
  default     = "cefiro_db_data"
}

variable "redis_data_volume" {
  description = "Named volume for Redis persistence (/data)."
  type        = string
  default     = "cefiro_redis_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the Cefiro app task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

variable "postgres_resources" {
  description = "Resources for the PostgreSQL task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
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

variable "obscura_resources" {
  description = "Resources for the Obscura renderer (runs headless Chromium)."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
