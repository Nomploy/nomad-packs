variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ghostfolio"
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
  description = "The Ghostfolio app image. Pin a tag in production."
  type        = string
  default     = "ghostfolio/ghostfolio:latest"
}

variable "postgres_image" {
  description = "The PostgreSQL image for the bundled database."
  type        = string
  default     = "postgres:16-alpine"
}

variable "redis_image" {
  description = "The Redis image for the cache and job queues."
  type        = string
  default     = "redis:7-alpine"
}

variable "port" {
  description = "Host port for the Ghostfolio web app (PORT)."
  type        = number
  default     = 3333
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

variable "db_password" {
  description = "Password for the Ghostfolio PostgreSQL user."
  type        = string
  default     = "ghostfolio"
}

variable "redis_password" {
  description = "Password for the co-located Redis (REDIS_PASSWORD)."
  type        = string
  default     = "ghostfolio"
}

variable "access_token_salt" {
  description = "Salt used to hash security/access tokens (ACCESS_TOKEN_SALT). CHANGE THIS — generate with: openssl rand -hex 16."
  type        = string
  default     = "change-me-access-token-salt"
}

variable "jwt_secret_key" {
  description = "Secret used to sign JWTs (JWT_SECRET_KEY). CHANGE THIS — generate with: openssl rand -hex 32."
  type        = string
  default     = "change-me-jwt-secret-key"
}

variable "db_data_volume" {
  description = "Named volume for PostgreSQL data (/var/lib/postgresql/data). Holds all accounts and activities."
  type        = string
  default     = "ghostfolio_db_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the Ghostfolio app task."
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
