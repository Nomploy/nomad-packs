variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "immich"
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
  description = "The Immich server image. Pin a tag in production (keep it in sync with machine_learning_image)."
  type        = string
  default     = "ghcr.io/immich-app/immich-server:release"
}

variable "machine_learning_image" {
  description = "The Immich machine-learning image. Keep its tag in sync with the server image."
  type        = string
  default     = "ghcr.io/immich-app/immich-machine-learning:release"
}

variable "postgres_image" {
  description = "The Immich PostgreSQL image. This is a special build with the required vector extensions — do not swap it for stock postgres."
  type        = string
  default     = "ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0"
}

variable "redis_image" {
  description = "The Redis/Valkey image used as the job queue."
  type        = string
  default     = "valkey/valkey:8-bookworm"
}

variable "port" {
  description = "Host port for the Immich web UI / API."
  type        = number
  default     = 2283
}

variable "db_port" {
  description = "Host port for the bundled PostgreSQL (loopback only)."
  type        = number
  default     = 5432
}

variable "redis_port" {
  description = "Host port for the bundled Redis/Valkey (loopback only)."
  type        = number
  default     = 6379
}

variable "ml_port" {
  description = "Host port for the machine-learning service (loopback only). Fixed at 3003 inside the image."
  type        = number
  default     = 3003
}

variable "db_user" {
  description = "PostgreSQL username."
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "PostgreSQL password. CHANGE THIS. Use alphanumeric characters only (no special characters)."
  type        = string
  default     = "change-me-immich-postgres"
}

variable "db_name" {
  description = "PostgreSQL database name."
  type        = string
  default     = "immich"
}

variable "upload_volume" {
  description = "Named volume mounted at /data — your photo and video library. This grows large; back it up."
  type        = string
  default     = "immich_upload"
}

variable "db_data_volume" {
  description = "Named volume for the PostgreSQL data directory."
  type        = string
  default     = "immich_db"
}

variable "model_cache_volume" {
  description = "Named volume for the machine-learning model cache (/cache)."
  type        = string
  default     = "immich_model_cache"
}

variable "redis_data_volume" {
  description = "Named volume for Redis/Valkey persistence (/data)."
  type        = string
  default     = "immich_redis"
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
  description = "Resources for the Immich server task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}

variable "machine_learning_resources" {
  description = "Resources for the machine-learning task. Model inference is CPU/RAM heavy."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1536
  }
}

variable "postgres_resources" {
  description = "Resources for the PostgreSQL task."
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
  description = "Resources for the Redis/Valkey task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
